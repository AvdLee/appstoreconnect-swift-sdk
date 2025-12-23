#if os(macOS)
import XCTest
@testable import OpenAPIGeneratorCore

final class SpecPatchingTests: XCTestCase {
    func testOrderPreservedWhenParsingAndWritingJSON() throws {
        // This test guards against losing upstream key ordering via JSONDecoder/JSONEncoder.
        let input = """
        {"b":1,"a":2,"c":{"y":true,"x":false},"arr":[{"k2":2,"k1":1}]}
        """
        let data = Data(input.utf8)

        let root = try JSONValue(jsonDataPreservingKeyOrder: data)

        let outData = try root.toJSONData(prettyPrinted: false)
        let out = String(data: outData, encoding: .utf8)
        XCTAssertEqual(out, input)
    }

    func testEnsuresPurchaseRequirementEnum() throws {
        let rootObj: NSDictionary = [
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
        var root = JSONValue(foundationObject: rootObj)

        _ = try SpecPatcher.patch(&root)

        let values =
            root.objectValue?["schema"]?.objectValue?["properties"]?.objectValue?["purchaseRequirement"]?.objectValue?["enum"]?.arrayValue?
            .compactMap { $0.stringValue }
        XCTAssertEqual(values, ["NO_COST_ASSOCIATED", "IN_APP_PURCHASE"])
    }

    func testEnsuresResponseErrorAndErrorResponseItemsRef() throws {
        let rootObj: NSDictionary = [
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
        var root = JSONValue(foundationObject: rootObj)

        let result = try SpecPatcher.patch(&root)
        XCTAssertTrue(result.didChange)

        let schemas = root.objectValue?["components"]?.objectValue?["schemas"]?.objectValue
        XCTAssertNotNil(schemas?["ResponseError"])

        let itemsRef =
            schemas?["ErrorResponse"]?.objectValue?["properties"]?.objectValue?["errors"]?.objectValue?["items"]?.objectValue?["$ref"]?.stringValue
        XCTAssertEqual(itemsRef, "#/components/schemas/ResponseError")
    }
}
#endif


