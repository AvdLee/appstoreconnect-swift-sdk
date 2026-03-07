import Foundation
import OrderedCollections

public enum SpecPatchingError: Error, CustomStringConvertible {
    case invalidRootJSON
    case invalidComponentsSchemas

    public var description: String {
        switch self {
        case .invalidRootJSON:
            return "Spec root must be a JSON object"
        case .invalidComponentsSchemas:
            return "Spec must contain components.schemas as an object"
        }
    }
}

/// Applies the project’s “spec fixes” in a structure-aware way (no line-based patches).
/// This version uses `OrderedDictionary`-backed JSON to preserve key ordering when rewriting the spec.
public enum SpecPatcher {
    public enum RuleID: String, CaseIterable {
        case bundleIdPlatformEnum = "bundleidplatform-enum"
        case removeEmptyEnums = "remove-empty-enums"
        case appEventDeepLinkFormat = "appevent-deeplink-format"
        case purchaseRequirementEnum = "purchase-requirement-enum"
        case responseErrorSchema = "response-error-schema"
    }

    public struct RuleResult {
        public var id: RuleID
        public var didChange: Bool
        public var matchCount: Int
        public var zeroMatchesIsOK: Bool

        public init(id: RuleID, didChange: Bool, matchCount: Int, zeroMatchesIsOK: Bool = false) {
            self.id = id
            self.didChange = didChange
            self.matchCount = matchCount
            self.zeroMatchesIsOK = zeroMatchesIsOK
        }
    }

    public struct Result {
        public var didChange: Bool
        public var changes: [String]
        public var rules: [RuleResult]

        public init(didChange: Bool, changes: [String], rules: [RuleResult]) {
            self.didChange = didChange
            self.changes = changes
            self.rules = rules
        }
    }

    public static func patch(_ root: inout JSONValue) throws -> Result {
        guard case .object(var rootObject) = root else {
            throw SpecPatchingError.invalidRootJSON
        }

        var didChange = false
        var changes: [String] = []
        var rules: [RuleResult] = []

        let bundle = ensureBundleIdPlatformEnum(&rootObject)
        rules.append(.init(id: .bundleIdPlatformEnum, didChange: bundle.didChange, matchCount: bundle.matchCount))
        if bundle.didChange {
            didChange = true
            changes.append("Ensured BundleIdPlatform enum values")
        }

        let emptyEnums = removeEmptyEnums(&rootObject)
        rules.append(.init(id: .removeEmptyEnums, didChange: emptyEnums.didChange, matchCount: emptyEnums.matchCount, zeroMatchesIsOK: true))
        if emptyEnums.didChange {
            didChange = true
            changes.append("Removed empty enums")
        }

        let deepLink = ensureAppEventDeepLinkIsStringWithoutFormat(&rootObject)
        rules.append(.init(id: .appEventDeepLinkFormat, didChange: deepLink.didChange, matchCount: deepLink.matchCount))
        if deepLink.didChange {
            didChange = true
            changes.append("Ensured AppEvent.deepLink is string with null format")
        }

        let pr = ensurePurchaseRequirementEnum(&rootObject)
        rules.append(.init(id: .purchaseRequirementEnum, didChange: pr.didChange, matchCount: pr.matchCount))
        if pr.didChange {
            didChange = true
            changes.append("Ensured purchaseRequirement enum values")
        }

        let re = try ensureResponseErrorSchemaAndRef(&rootObject)
        rules.append(.init(id: .responseErrorSchema, didChange: re.didChange, matchCount: re.matchCount))
        if re.didChange {
            didChange = true
            changes.append("Ensured ResponseError schema and referenced it from ErrorResponse")
        }

        root = .object(rootObject)
        return .init(didChange: didChange, changes: changes, rules: rules)
    }
}

// MARK: - Patch implementations

private struct PatchOutcome {
    var didChange: Bool
    var matchCount: Int
}

private func ensureBundleIdPlatformEnum(_ root: inout OrderedDictionary<String, JSONValue>) -> PatchOutcome {
    guard
        var components = root["components"]?.objectValue,
        var schemas = components["schemas"]?.objectValue,
        var bundleIdPlatform = schemas["BundleIdPlatform"]?.objectValue,
        var values = bundleIdPlatform["enum"]?.arrayValue
    else {
        return .init(didChange: false, matchCount: 0)
    }

    var didChange = false
    let matchCount = 1

    if !values.contains(.string("SERVICES")) {
        values.append(.string("SERVICES"))
        didChange = true
    }

    if didChange {
        bundleIdPlatform["enum"] = .array(values)
        schemas["BundleIdPlatform"] = .object(bundleIdPlatform)
        components["schemas"] = .object(schemas)
        root["components"] = .object(components)
    }

    return .init(didChange: didChange, matchCount: matchCount)
}

private func removeEmptyEnums(_ root: inout OrderedDictionary<String, JSONValue>) -> PatchOutcome {
    var didChange = false
    var removedCount = 0

    func patchNode(_ node: inout JSONValue) {
        switch node {
        case .object(var dict):
            if case .array(let e) = dict["enum"], e.isEmpty {
                dict.removeValue(forKey: "enum")
                removedCount += 1
                didChange = true
            }

            for key in Array(dict.keys) {
                guard var v = dict[key] else { continue }
                patchNode(&v)
                dict[key] = v
            }
            node = .object(dict)
        case .array(var arr):
            for i in arr.indices {
                var v = arr[i]
                patchNode(&v)
                arr[i] = v
            }
            node = .array(arr)
        default:
            break
        }
    }

    var rootValue: JSONValue = .object(root)
    patchNode(&rootValue)
    if case .object(let patched) = rootValue {
        root = patched
    }
    return .init(didChange: didChange, matchCount: removedCount)
}

private func ensureAppEventDeepLinkIsStringWithoutFormat(_ root: inout OrderedDictionary<String, JSONValue>) -> PatchOutcome {
    guard
        var components = root["components"]?.objectValue,
        var schemas = components["schemas"]?.objectValue,
        var appEvent = schemas["AppEvent"]?.objectValue,
        var props = appEvent["properties"]?.objectValue,
        var attributes = props["attributes"]?.objectValue,
        var attrProps = attributes["properties"]?.objectValue,
        var deepLink = attrProps["deepLink"]?.objectValue
    else {
        return .init(didChange: false, matchCount: 0)
    }

    var didChange = false
    let matchCount = 1

    if deepLink["type"] != .string("string") {
        deepLink["type"] = .string("string")
        didChange = true
    }

    if let format = deepLink["format"] {
        if format != .null {
            deepLink["format"] = .null
            didChange = true
        }
    } else {
        deepLink["format"] = .null
        didChange = true
    }

    if didChange {
        attrProps["deepLink"] = .object(deepLink)
        attributes["properties"] = .object(attrProps)
        props["attributes"] = .object(attributes)
        appEvent["properties"] = .object(props)
        schemas["AppEvent"] = .object(appEvent)
        components["schemas"] = .object(schemas)
        root["components"] = .object(components)
    }

    return .init(didChange: didChange, matchCount: matchCount)
}

private func ensurePurchaseRequirementEnum(_ root: inout OrderedDictionary<String, JSONValue>) -> PatchOutcome {
    var didChange = false
    var matchCount = 0
    let desiredEnum: JSONValue = .array([.string("NO_COST_ASSOCIATED"), .string("IN_APP_PURCHASE")])

    func patchNode(_ node: inout JSONValue) {
        switch node {
        case .object(var dict):
            if var pr = dict["purchaseRequirement"]?.objectValue,
               pr["type"] == .string("string") {
                matchCount += 1
                if pr["enum"] != desiredEnum {
                    pr["enum"] = desiredEnum
                    dict["purchaseRequirement"] = .object(pr)
                    didChange = true
                }
            }

            for key in Array(dict.keys) {
                guard var v = dict[key] else { continue }
                patchNode(&v)
                dict[key] = v
            }
            node = .object(dict)
        case .array(var arr):
            for i in arr.indices {
                var v = arr[i]
                patchNode(&v)
                arr[i] = v
            }
            node = .array(arr)
        default:
            break
        }
    }

    var rootValue: JSONValue = .object(root)
    patchNode(&rootValue)
    if case .object(let patched) = rootValue {
        root = patched
    }

    return .init(didChange: didChange, matchCount: matchCount)
}

private func ensureResponseErrorSchemaAndRef(_ root: inout OrderedDictionary<String, JSONValue>) throws -> PatchOutcome {
    guard
        var components = root["components"]?.objectValue,
        var schemas = components["schemas"]?.objectValue
    else {
        throw SpecPatchingError.invalidComponentsSchemas
    }

    var didChange = false

    var matchCount = 0
    guard
        var errorResponse = schemas["ErrorResponse"]?.objectValue,
        var props = errorResponse["properties"]?.objectValue,
        var errors = props["errors"]?.objectValue
    else {
        return .init(didChange: false, matchCount: 0)
    }

    matchCount = 1

    func obj(_ pairs: [(String, JSONValue)]) -> JSONValue {
        .object(OrderedDictionary(uniqueKeysWithValues: pairs))
    }

    let responseErrorSchema: JSONValue = obj([
        ("type", .string("object")),
        ("properties", obj([
            ("id", obj([("type", .string("string"))])),
            ("status", obj([("type", .string("string"))])),
            ("code", obj([("type", .string("string"))])),
            ("title", obj([("type", .string("string"))])),
            ("detail", obj([("type", .string("string"))])),
            ("source", obj([
                ("oneOf", .array([
                    obj([("$ref", .string("#/components/schemas/ErrorSourcePointer"))]),
                    obj([("$ref", .string("#/components/schemas/ErrorSourceParameter"))]),
                ])),
            ])),
            ("links", obj([("$ref", .string("#/components/schemas/ErrorLinks"))])),
            ("meta", obj([
                ("type", .string("object")),
                ("properties", obj([
                    ("associatedErrors", obj([
                        ("type", .string("object")),
                        ("additionalProperties", obj([
                            ("type", .string("array")),
                            ("items", obj([("$ref", .string("#/components/schemas/ResponseError"))])),
                        ])),
                    ])),
                ])),
                ("additionalProperties", .bool(true)),
            ])),
        ])),
        ("required", .array([.string("code"), .string("status"), .string("title")])),
    ])

    if schemas["ResponseError"] != responseErrorSchema {
        schemas["ResponseError"] = responseErrorSchema
        didChange = true
    }

    let desiredItems: JSONValue = obj([("$ref", .string("#/components/schemas/ResponseError"))])
    if errors["items"] != desiredItems {
        errors["items"] = desiredItems
        props["errors"] = .object(errors)
        errorResponse["properties"] = .object(props)
        schemas["ErrorResponse"] = .object(errorResponse)
        didChange = true
    }

    if didChange {
        components["schemas"] = .object(schemas)
        root["components"] = .object(components)
    }

    return .init(didChange: didChange, matchCount: matchCount)
}


