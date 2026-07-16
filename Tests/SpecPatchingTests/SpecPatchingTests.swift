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

    func testRemovesKidsAgeBandFromAppInfosFieldsOnly() throws {
        let rootObj: OrderedDictionary<String, JSONValue> = [
            "components": .object([
                "schemas": .object([
                    "AppInfo": .object([
                        "properties": .object([
                            "attributes": .object([
                                "properties": .object([
                                    "appStoreState": .object(["type": .string("string")]),
                                    "kidsAgeBand": .object([
                                        "deprecated": .bool(true),
                                        "$ref": .string("#/components/schemas/KidsAgeBand"),
                                    ]),
                                ]),
                            ]),
                        ]),
                    ]),
                ]),
            ]),
            "paths": .object([
                "/v1/apps/{id}/appInfos": .object([
                    "get": .object([
                        "parameters": .array([
                            .object([
                                "name": .string("fields[appInfos]"),
                                "schema": .object([
                                    "type": .string("array"),
                                    "items": .object([
                                        "type": .string("string"),
                                        "enum": .array([
                                            .string("appStoreState"),
                                            .string("kidsAgeBand"),
                                            .string("ageRatingDeclaration"),
                                        ]),
                                    ]),
                                ]),
                            ]),
                            .object([
                                "name": .string("fields[ageRatingDeclarations]"),
                                "schema": .object([
                                    "type": .string("array"),
                                    "items": .object([
                                        "type": .string("string"),
                                        "enum": .array([
                                            .string("gambling"),
                                            .string("kidsAgeBand"),
                                            .string("lootBox"),
                                        ]),
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
        XCTAssertTrue(result.changes.contains("Removed kidsAgeBand from fields[appInfos]"))

        let appInfoProps =
            root.objectValue?["components"]?.objectValue?["schemas"]?.objectValue?["AppInfo"]?
            .objectValue?["properties"]?.objectValue?["attributes"]?.objectValue?["properties"]?.objectValue
        XCTAssertNotNil(appInfoProps?["kidsAgeBand"])

        let parameters =
            root.objectValue?["paths"]?.objectValue?["/v1/apps/{id}/appInfos"]?.objectValue?["get"]?
            .objectValue?["parameters"]?.arrayValue
        let appInfosFields =
            parameters?[0].objectValue?["schema"]?.objectValue?["items"]?.objectValue?["enum"]?.arrayValue?
            .compactMap(\.stringValue)
        let ageRatingFields =
            parameters?[1].objectValue?["schema"]?.objectValue?["items"]?.objectValue?["enum"]?.arrayValue?
            .compactMap(\.stringValue)

        XCTAssertEqual(appInfosFields, ["appStoreState", "ageRatingDeclaration"])
        XCTAssertEqual(ageRatingFields, ["gambling", "kidsAgeBand", "lootBox"])
    }
}
#endif


