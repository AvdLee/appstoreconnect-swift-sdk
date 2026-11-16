#if os(macOS)
import XCTest
import OrderedCollections
@testable import OpenAPIGeneratorCore

final class SpecPatchingTests: XCTestCase {
    func testRoutingCoverageRelatedResponseIsRequiredAndNullableWithoutChangingResourceResponses() throws {
        let input = #"""
        {
          "paths": {
            "/v1/appStoreVersions/{id}/routingAppCoverage": {
              "get": {"responses": {"200": {"content": {"application/json": {
                "schema": {"$ref": "#/components/schemas/RoutingAppCoverageResponse"}
              }}}}}
            },
            "/v1/routingAppCoverages/{id}": {
              "get": {"responses": {"200": {"content": {"application/json": {
                "schema": {"$ref": "#/components/schemas/RoutingAppCoverageResponse"}
              }}}}}
            }
          },
          "components": {"schemas": {
            "RoutingAppCoverageResponse": {
              "title": "RoutingAppCoverageResponse", "type": "object",
              "properties": {
                "data": {"$ref": "#/components/schemas/RoutingAppCoverage"},
                "links": {"$ref": "#/components/schemas/DocumentLinks"}
              },
              "required": ["data", "links"]
            }
          }}
        }
        """#
        var parser = JSONParser(bytes: Array(input.utf8))
        var root = try parser.parse()
        let original = root.objectValue?["components"]?.objectValue?["schemas"]?.objectValue?["RoutingAppCoverageResponse"]
        let directEndpoint = root.objectValue?["paths"]?.objectValue?["/v1/routingAppCoverages/{id}"]

        let first = try SpecPatcher.patch(&root)
        XCTAssertTrue(first.didChange)
        let schemas = root.objectValue?["components"]?.objectValue?["schemas"]?.objectValue
        let related = schemas?["AppStoreVersionRoutingAppCoverageResponse"]?.objectValue
        let data = related?["properties"]?.objectValue?["data"]?.objectValue
        XCTAssertEqual(data?["nullable"]?.boolValue, true)
        XCTAssertEqual(data?["allOf"]?.arrayValue?.first?.objectValue?["$ref"]?.stringValue, "#/components/schemas/RoutingAppCoverage")
        XCTAssertEqual(related?["required"]?.arrayValue?.compactMap(\.stringValue), ["data", "links"])
        XCTAssertEqual(schemas?["RoutingAppCoverageResponse"], original)
        let paths = root.objectValue?["paths"]?.objectValue
        XCTAssertEqual(paths?["/v1/routingAppCoverages/{id}"], directEndpoint)
        let ref = paths?["/v1/appStoreVersions/{id}/routingAppCoverage"]?.objectValue?["get"]?.objectValue?["responses"]?
            .objectValue?["200"]?.objectValue?["content"]?.objectValue?["application/json"]?.objectValue?["schema"]?.objectValue?["$ref"]?.stringValue
        XCTAssertEqual(ref, "#/components/schemas/AppStoreVersionRoutingAppCoverageResponse")

        let once = root
        let second = try SpecPatcher.patch(&root)
        XCTAssertFalse(second.didChange)
        XCTAssertEqual(root, once)
    }

    func testPlacementRequestSchemasRetainCommonFieldsForGeneration() throws {
        let input = """
        {"components":{"schemas":{"AppAssetLibraryPlacementCreateRequest":{"properties":{"data":{"properties":{"type":{"type":"string"},"attributes":{"type":"object","properties":{"placementGroup":{"type":"string"}}},"relationships":{"type":"object"}},"anyOf":[{"required":["attributes","relationships"]}],"required":["type"]}}},"AppAssetLibraryPlacementOrderingRequestCreateRequest":{"properties":{"data":{"properties":{"type":{"type":"string"},"attributes":{"type":"object"},"relationships":{"type":"object"}},"anyOf":[{"required":["attributes","relationships"]}],"required":["type"]}}}}}}
        """
        var parser = JSONParser(bytes: Array(input.utf8))
        var root = JSONValue.object(try parser.parseObject())

        let result = try SpecPatcher.patch(&root)

        XCTAssertTrue(result.didChange)
        let schemas = root.objectValue?["components"]?.objectValue?["schemas"]?.objectValue
        for name in ["AppAssetLibraryPlacementCreateRequest", "AppAssetLibraryPlacementOrderingRequestCreateRequest"] {
            let data = schemas?[name]?.objectValue?["properties"]?.objectValue?["data"]?.objectValue
            XCTAssertNil(data?["anyOf"])
            XCTAssertEqual(data?["required"]?.arrayValue?.compactMap(\.stringValue), ["type", "attributes", "relationships"])
            XCTAssertNotNil(data?["properties"]?.objectValue?["type"])
        }
        let createAttributes = schemas?["AppAssetLibraryPlacementCreateRequest"]?.objectValue?["properties"]?
            .objectValue?["data"]?.objectValue?["properties"]?.objectValue?["attributes"]?.objectValue?["properties"]?.objectValue
        XCTAssertNotNil(createAttributes?["placementGroup"])
    }

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

    func testRequiresNominationRelationshipDataArrays() throws {
        let input = """
        {"components":{"schemas":{"NominationCreateRequest":{"properties":{"data":{"properties":{"relationships":{"properties":{"relatedApps":{"type":"object","properties":{"data":{"type":"array"}},"required":["data"]},"inAppEvents":{"type":"object","properties":{"data":{"type":"array"}}},"supportedTerritories":{"type":"object","properties":{"data":{"type":"array"}}}}}}}}},"NominationUpdateRequest":{"properties":{"data":{"properties":{"relationships":{"properties":{"relatedApps":{"type":"object","properties":{"data":{"type":"array"}}},"inAppEvents":{"type":"object","properties":{"data":{"type":"array"}}},"supportedTerritories":{"type":"object","properties":{"data":{"type":"array"}}}}}}}}}}}}
        """
        var parser = JSONParser(bytes: Array(input.utf8))
        var root = JSONValue.object(try parser.parseObject())

        let result = try SpecPatcher.patch(&root)

        XCTAssertTrue(result.didChange)
        XCTAssertTrue(result.changes.contains("Ensured Nomination relationship data arrays are required"))

        let schemas = root.objectValue?["components"]?.objectValue?["schemas"]?.objectValue
        for schemaName in ["NominationCreateRequest", "NominationUpdateRequest"] {
            let relationshipProperties =
                schemas?[schemaName]?.objectValue?["properties"]?.objectValue?["data"]?
                .objectValue?["properties"]?.objectValue?["relationships"]?
                .objectValue?["properties"]?.objectValue

            for relationshipName in ["relatedApps", "inAppEvents", "supportedTerritories"] {
                let required = relationshipProperties?[relationshipName]?.objectValue?["required"]?.arrayValue?.compactMap(\.stringValue)
                XCTAssertEqual(required, ["data"], "\(schemaName).\(relationshipName)")
            }
        }
    }
}
#endif
