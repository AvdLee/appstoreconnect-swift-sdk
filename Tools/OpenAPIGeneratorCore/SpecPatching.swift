import Foundation

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

    public static func patch(_ root: inout [String: Any]) throws -> Result {
        var didChange = false
        var changes: [String] = []
        var rules: [RuleResult] = []

        let bundle = ensureBundleIdPlatformEnum(&root)
        rules.append(.init(id: .bundleIdPlatformEnum, didChange: bundle.didChange, matchCount: bundle.matchCount))
        if bundle.didChange {
            didChange = true
            changes.append("Ensured BundleIdPlatform enum values")
        }

        let emptyEnums = removeEmptyEnums(&root)
        rules.append(.init(id: .removeEmptyEnums, didChange: emptyEnums.didChange, matchCount: emptyEnums.matchCount, zeroMatchesIsOK: true))
        if emptyEnums.didChange {
            didChange = true
            changes.append("Removed empty enums")
        }

        let deepLink = ensureAppEventDeepLinkIsStringWithoutFormat(&root)
        rules.append(.init(id: .appEventDeepLinkFormat, didChange: deepLink.didChange, matchCount: deepLink.matchCount))
        if deepLink.didChange {
            didChange = true
            changes.append("Ensured AppEvent.deepLink is string with null format")
        }

        let pr = ensurePurchaseRequirementEnum(&root)
        rules.append(.init(id: .purchaseRequirementEnum, didChange: pr.didChange, matchCount: pr.matchCount))
        if pr.didChange {
            didChange = true
            changes.append("Ensured purchaseRequirement enum values")
        }

        let re = try ensureResponseErrorSchemaAndRef(&root)
        rules.append(.init(id: .responseErrorSchema, didChange: re.didChange, matchCount: re.matchCount))
        if re.didChange {
            didChange = true
            changes.append("Ensured ResponseError schema and referenced it from ErrorResponse")
        }

        return .init(didChange: didChange, changes: changes, rules: rules)
    }
}

// MARK: - Patch implementations

private struct PatchOutcome {
    var didChange: Bool
    var matchCount: Int
}

private func ensureBundleIdPlatformEnum(_ root: inout [String: Any]) -> PatchOutcome {
    guard
        var components = root["components"] as? [String: Any],
        var schemas = components["schemas"] as? [String: Any],
        var bundleIdPlatform = schemas["BundleIdPlatform"] as? [String: Any],
        var values = bundleIdPlatform["enum"] as? [Any]
    else {
        return .init(didChange: false, matchCount: 0)
    }

    var didChange = false
    let matchCount = 1

    if !values.contains(where: { ($0 as? String) == "SERVICES" }) {
        values.append("SERVICES")
        didChange = true
    }

    if didChange {
        bundleIdPlatform["enum"] = values
        schemas["BundleIdPlatform"] = bundleIdPlatform
        components["schemas"] = schemas
        root["components"] = components
    }

    return .init(didChange: didChange, matchCount: matchCount)
}

private func removeEmptyEnums(_ root: inout [String: Any]) -> PatchOutcome {
    var didChange = false
    var removedCount = 0

    func patchNode(_ node: inout Any) {
        if var dict = node as? [String: Any] {
            if let e = dict["enum"] as? [Any], e.isEmpty {
                dict.removeValue(forKey: "enum")
                removedCount += 1
                didChange = true
            }
            for key in Array(dict.keys) {
                var v = dict[key] as Any
                patchNode(&v)
                dict[key] = v
            }
            node = dict
            return
        }

        if var arr = node as? [Any] {
            for i in arr.indices {
                var v = arr[i]
                patchNode(&v)
                arr[i] = v
            }
            node = arr
            return
        }
    }

    var anyRoot: Any = root
    patchNode(&anyRoot)
    if let patchedRoot = anyRoot as? [String: Any] {
        root = patchedRoot
    }
    return .init(didChange: didChange, matchCount: removedCount)
}

private func ensureAppEventDeepLinkIsStringWithoutFormat(_ root: inout [String: Any]) -> PatchOutcome {
    guard
        var components = root["components"] as? [String: Any],
        var schemas = components["schemas"] as? [String: Any],
        var appEvent = schemas["AppEvent"] as? [String: Any],
        var props = appEvent["properties"] as? [String: Any],
        var attributes = props["attributes"] as? [String: Any],
        var attrProps = attributes["properties"] as? [String: Any],
        var deepLink = attrProps["deepLink"] as? [String: Any]
    else {
        return .init(didChange: false, matchCount: 0)
    }

    var didChange = false
    let matchCount = 1

    if (deepLink["type"] as? String) != "string" {
        deepLink["type"] = "string"
        didChange = true
    }

    if let format = deepLink["format"], !(format is NSNull) {
        deepLink["format"] = NSNull()
        didChange = true
    } else if deepLink["format"] == nil {
        deepLink["format"] = NSNull()
        didChange = true
    }

    if didChange {
        attrProps["deepLink"] = deepLink
        attributes["properties"] = attrProps
        props["attributes"] = attributes
        appEvent["properties"] = props
        schemas["AppEvent"] = appEvent
        components["schemas"] = schemas
        root["components"] = components
    }

    return .init(didChange: didChange, matchCount: matchCount)
}

private func ensurePurchaseRequirementEnum(_ root: inout [String: Any]) -> PatchOutcome {
    var didChange = false
    var matchCount = 0
    let desiredEnum: [Any] = ["NO_COST_ASSOCIATED", "IN_APP_PURCHASE"]

    func patchNode(_ node: inout Any) {
        if var dict = node as? [String: Any] {
            if var pr = dict["purchaseRequirement"] as? [String: Any],
               (pr["type"] as? String) == "string" {
                matchCount += 1
                let existing = pr["enum"] as? [Any]
                if existing == nil || !NSArray(array: existing ?? []).isEqual(to: desiredEnum) {
                    pr["enum"] = desiredEnum
                    dict["purchaseRequirement"] = pr
                    didChange = true
                }
            }

            for key in dict.keys {
                var v = dict[key] as Any
                patchNode(&v)
                dict[key] = v
            }
            node = dict
            return
        }

        if var arr = node as? [Any] {
            for i in arr.indices {
                var v = arr[i]
                patchNode(&v)
                arr[i] = v
            }
            node = arr
            return
        }
    }

    var anyRoot: Any = root
    patchNode(&anyRoot)
    if let patchedRoot = anyRoot as? [String: Any] {
        root = patchedRoot
    }

    return .init(didChange: didChange, matchCount: matchCount)
}

private func ensureResponseErrorSchemaAndRef(_ root: inout [String: Any]) throws -> PatchOutcome {
    guard
        var components = root["components"] as? [String: Any],
        var schemas = components["schemas"] as? [String: Any]
    else {
        throw SpecPatchingError.invalidComponentsSchemas
    }

    var didChange = false

    var matchCount = 0
    guard
        var errorResponse = schemas["ErrorResponse"] as? [String: Any],
        var props = errorResponse["properties"] as? [String: Any],
        var errors = props["errors"] as? [String: Any]
    else {
        return .init(didChange: false, matchCount: 0)
    }

    matchCount = 1

    let responseErrorSchema: [String: Any] = [
        "type": "object",
        "properties": [
            "id": ["type": "string"],
            "status": ["type": "string"],
            "code": ["type": "string"],
            "title": ["type": "string"],
            "detail": ["type": "string"],
            "source": [
                "oneOf": [
                    ["$ref": "#/components/schemas/ErrorSourcePointer"],
                    ["$ref": "#/components/schemas/ErrorSourceParameter"],
                ]
            ],
            "links": ["$ref": "#/components/schemas/ErrorLinks"],
            "meta": [
                "type": "object",
                "properties": [
                    "associatedErrors": [
                        "type": "object",
                        "additionalProperties": [
                            "type": "array",
                            "items": ["$ref": "#/components/schemas/ResponseError"],
                        ]
                    ]
                ],
                "additionalProperties": true,
            ],
        ],
        "required": ["code", "status", "title"],
    ]

    if let existing = schemas["ResponseError"] as? [String: Any] {
        if !NSDictionary(dictionary: existing).isEqual(to: responseErrorSchema) {
            schemas["ResponseError"] = responseErrorSchema
            didChange = true
        }
    } else {
        schemas["ResponseError"] = responseErrorSchema
        didChange = true
    }

    let desiredItems: [String: Any] = ["$ref": "#/components/schemas/ResponseError"]
    if let items = errors["items"] as? [String: Any] {
        if !NSDictionary(dictionary: items).isEqual(to: desiredItems) {
            errors["items"] = desiredItems
            props["errors"] = errors
            errorResponse["properties"] = props
            schemas["ErrorResponse"] = errorResponse
            didChange = true
        }
    } else {
        errors["items"] = desiredItems
        props["errors"] = errors
        errorResponse["properties"] = props
        schemas["ErrorResponse"] = errorResponse
        didChange = true
    }

    if didChange {
        components["schemas"] = schemas
        root["components"] = components
    }

    return .init(didChange: didChange, matchCount: matchCount)
}



