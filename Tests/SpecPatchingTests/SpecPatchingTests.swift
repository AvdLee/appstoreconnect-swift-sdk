#if os(macOS)
import XCTest
import OrderedCollections
@testable import OpenAPIGeneratorCore

final class SpecPatchingTests: XCTestCase {
    func testOrderPreservedWhenParsingAndWritingJSON() throws {
        // This test guards against losing upstream key ordering via JSONDecoder/JSONEncoder.
        let input = """
        {"b":1,"a":2,"c":{"y":true,"x":false},"arr":[{"k2":2,"k1":1}]}
        """
        var parser = JSONParser(bytes: Array(input.utf8))
        let orderedDictionary = try parser.parseObject()

        let root = JSONValue.object(orderedDictionary)

        let outData = try root.toJSONData(prettyPrinted: false)
        let out = String(data: outData, encoding: .utf8)
        XCTAssertEqual(out, input)
    }

    func testEnsuresPurchaseRequirementEnum() throws {
        let rootObj: OrderedDictionary<String, JSONValue> = [
            "components": .object(
                ["schemas": .object([:])]
            ),
            "schema": .object(
                ["properties": .object(
                    ["purchaseRequirement": .object(
                        ["type": .string("string")]
                    )]
                )]
            )
        ]
        var root = JSONValue.object(rootObj)

        _ = try SpecPatcher.patch(&root)

        let values =
            root.objectValue?["schema"]?.objectValue?["properties"]?.objectValue?["purchaseRequirement"]?.objectValue?["enum"]?.arrayValue?
            .compactMap { $0.stringValue }
        XCTAssertEqual(values, ["NO_COST_ASSOCIATED", "IN_APP_PURCHASE"])
    }

    func testEnsuresResponseErrorAndErrorResponseItemsRef() throws {
        let rootObj: OrderedDictionary<String, JSONValue> = [
            "components": .object([
                "schemas": .object([
                    "ErrorResponse": .object([
                        "type": .string("object"),
                        "properties": .object([
                            "errors": .object([
                                "type": .string("array"),
                                "items": .object([
                                    "type": .string("object"),
                                    "properties": .object([
                                        "code": .object(["type": .string("string")]),
                                        "status": .object(["type": .string("string")]),
                                        "title": .object(["type": .string("string")]),
                                        "detail": .object(["type": .string("string")]),
                                    ]),
                                ]),
                            ]),
                        ]),
                    ]),
                ]),
            ]),
        ]
        var root = JSONValue.object(rootObj)

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


