import XCTest
@testable import SpecPatching

final class SpecPatchingTests: XCTestCase {
    func testEnsuresPurchaseRequirementEnum() throws {
        var root: [String: Any] = [
            "components": [
                "schemas": [:]
            ],
            "schema": [
                "properties": [
                    "purchaseRequirement": [
                        "type": "string"
                    ]
                ]
            ]
        ]

        _ = try SpecPatcher.patch(&root)

        let schema = root["schema"] as? [String: Any]
        let props = schema?["properties"] as? [String: Any]
        let pr = props?["purchaseRequirement"] as? [String: Any]
        let values = pr?["enum"] as? [Any]
        XCTAssertEqual(values?.compactMap { $0 as? String }, ["NO_COST_ASSOCIATED", "IN_APP_PURCHASE"])
    }

    func testEnsuresResponseErrorAndErrorResponseItemsRef() throws {
        var root: [String: Any] = [
            "components": [
                "schemas": [
                    "ErrorResponse": [
                        "type": "object",
                        "properties": [
                            "errors": [
                                "type": "array",
                                "items": [
                                    "type": "object",
                                    "properties": [
                                        "code": ["type": "string"],
                                        "status": ["type": "string"],
                                        "title": ["type": "string"],
                                        "detail": ["type": "string"],
                                    ]
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ]

        let result = try SpecPatcher.patch(&root)
        XCTAssertTrue(result.didChange)

        let components = root["components"] as? [String: Any]
        let schemas = components?["schemas"] as? [String: Any]
        XCTAssertNotNil(schemas?["ResponseError"])

        let errorResponse = schemas?["ErrorResponse"] as? [String: Any]
        let props = errorResponse?["properties"] as? [String: Any]
        let errors = props?["errors"] as? [String: Any]
        let items = errors?["items"] as? [String: Any]
        XCTAssertEqual(items?["$ref"] as? String, "#/components/schemas/ResponseError")
    }
}


