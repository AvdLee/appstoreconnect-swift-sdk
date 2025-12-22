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
        case insertXKSIntoTerritoryEnums = "insert-xks"
        case purchaseRequirementEnum = "purchase-requirement-enum"
        case responseErrorSchema = "response-error-schema"
    }

    public struct RuleResult {
        public var id: RuleID
        /// Whether this rule modified the spec when evaluated.
        public var didChange: Bool
        /// How many targets in the spec matched what this rule expects.
        /// If this is 0, the upstream shape may have changed and the rule might need maintenance.
        public var matchCount: Int

        public init(id: RuleID, didChange: Bool, matchCount: Int) {
            self.id = id
            self.didChange = didChange
            self.matchCount = matchCount
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

        // 1) Constrain purchaseRequirement to the known enum values.
        let pr = ensurePurchaseRequirementEnum(&root)
        rules.append(.init(id: .purchaseRequirementEnum, didChange: pr.didChange, matchCount: pr.matchCount))
        if pr.didChange {
            didChange = true
            changes.append("Ensured purchaseRequirement enum values")
        }

        // 2) Factor ErrorResponse.errors.items into a reusable ResponseError schema.
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

    if matchCount == 0 {
        // Not throwing here can hide upstream spec shape changes; this is a maintenance signal.
        // Keeping it strict for "temporary patches" workflows.
        // (If this becomes noisy in the future, we can downgrade to a warning.)
        // NOTE: can't throw from here without changing signature; we already did.
        // So: represent as matchCount=0 and let CLI decide via --check-strict.
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

    // If the spec doesn't have ErrorResponse, we can't apply this rule meaningfully.
    // Return matchCount=0 so `SpecPatcher --check --strict` can flag it for maintenance.
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
        // If it exists but differs, overwrite to keep it deterministic.
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


