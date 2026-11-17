#if os(macOS)
import Foundation
import XCTest
@testable import OpenAPIGeneratorCore

final class ModuleSplitterTests: XCTestCase {
    private let config = ModuleSplitConfig(
        core: "Core",
        areas: [
            "AppStore": ["Apps", "AppStoreVersions"],
            "TestFlight": ["Builds", "BetaGroups"],
            "GameCenter": ["GameCenterDetails"],
        ]
    )

    private let routing = SpecRouting(
        topLevelResourceTags: [
            "apps": "Apps",
            "appStoreVersions": "AppStoreVersions",
            "builds": "Builds",
            "betaGroups": "BetaGroups",
            "gameCenterDetails": "GameCenterDetails",
        ],
        operationTags: [:]
    )

    // MARK: - Entity placement

    func testEntityUsedByOneAreaTransitivelyStaysInThatArea() throws {
        let split = try self.split([
            self.entity("BuildsResponse", references: ["Build"]),
            self.entity("Build", references: ["BuildAttributes"]),
            self.entity("BuildAttributes"),
            self.path("PathsV1Builds", "/v1/builds", returns: "BuildsResponse"),
        ])

        XCTAssertEqual(split.module(ofType: "BuildsResponse"), "TestFlight")
        XCTAssertEqual(split.module(ofType: "Build"), "TestFlight")
        XCTAssertEqual(split.module(ofType: "BuildAttributes"), "TestFlight")
        XCTAssertEqual(split.moduleByFile["Paths/PathsV1Builds.swift"], "TestFlight")
    }

    func testEntityReachableFromTwoAreasMovesToCoreTogetherWithEverythingItReferences() throws {
        let split = try self.split([
            self.entity("BuildsResponse", references: ["Build"]),
            self.entity("AppStoreVersionsResponse", references: ["AppStoreVersion"]),
            self.entity("AppStoreVersion", references: ["Build"]),
            self.entity("Build", references: ["ImageAsset"]),
            self.entity("ImageAsset"),
            self.path("PathsV1Builds", "/v1/builds", returns: "BuildsResponse"),
            self.path("PathsV1AppStoreVersions", "/v1/appStoreVersions", returns: "AppStoreVersionsResponse"),
        ])

        XCTAssertEqual(split.module(ofType: "Build"), "Core")
        // Anything a Core type references must be in Core as well, or Core would depend on an area.
        XCTAssertEqual(split.module(ofType: "ImageAsset"), "Core")
        XCTAssertEqual(split.module(ofType: "AppStoreVersion"), "AppStore")
        XCTAssertEqual(split.module(ofType: "BuildsResponse"), "TestFlight")
    }

    func testReferenceCycleIsNeverSplitAcrossModules() throws {
        // AppStoreVersion <-> Build form a cycle. Only Build is reachable from TestFlight directly,
        // but through the cycle both are reachable from both areas.
        let split = try self.split([
            self.entity("AppStoreVersion", references: ["Build"]),
            self.entity("Build", references: ["AppStoreVersion"]),
            self.entity("BuildsResponse", references: ["Build"]),
            self.entity("AppStoreVersionsResponse", references: ["AppStoreVersion"]),
            self.path("PathsV1Builds", "/v1/builds", returns: "BuildsResponse"),
            self.path("PathsV1AppStoreVersions", "/v1/appStoreVersions", returns: "AppStoreVersionsResponse"),
        ])

        XCTAssertEqual(split.module(ofType: "AppStoreVersion"), split.module(ofType: "Build"))
        XCTAssertEqual(split.module(ofType: "Build"), "Core")
    }

    func testEntityNotReachableFromAnyEndpointGoesToCoreAndIsReported() throws {
        let split = try self.split([
            self.entity("Orphan"),
            self.entity("BuildsResponse"),
            self.path("PathsV1Builds", "/v1/builds", returns: "BuildsResponse"),
        ])

        XCTAssertEqual(split.module(ofType: "Orphan"), "Core")
        XCTAssertEqual(split.unreachedEntities, ["Orphan"])
    }

    // MARK: - Reference detection

    func testTypeNamedOnlyInCommentsIsNotAReference() throws {
        let split = try self.split([
            GeneratedSource(path: "Entities/BuildsResponse.swift", contents: """
            /// Similar to `AppStoreVersion`, but for builds.
            public struct BuildsResponse: Codable {
            \t// Not an AppStoreVersion either.
            \tpublic var data: [String]
            }
            """),
            self.entity("AppStoreVersion"),
            self.entity("AppStoreVersionsResponse", references: ["AppStoreVersion"]),
            self.path("PathsV1Builds", "/v1/builds", returns: "BuildsResponse"),
            self.path("PathsV1AppStoreVersions", "/v1/appStoreVersions", returns: "AppStoreVersionsResponse"),
        ])

        XCTAssertEqual(split.module(ofType: "AppStoreVersion"), "AppStore")
    }

    func testNamesAreMatchedAsWholeIdentifiersNotPrefixes() throws {
        let split = try self.split([
            self.entity("App"),
            self.entity("AppInfo"),
            self.entity("AppsResponse", references: ["App"]),
            self.entity("BuildsResponse", references: ["AppInfo"]),
            self.path("PathsV1Apps", "/v1/apps", returns: "AppsResponse"),
            self.path("PathsV1Builds", "/v1/builds", returns: "BuildsResponse"),
        ])

        // `AppInfo` contains `App`, but only AppStore actually references `App`.
        XCTAssertEqual(split.module(ofType: "App"), "AppStore")
        XCTAssertEqual(split.module(ofType: "AppInfo"), "TestFlight")
    }

    func testNestedTypeNamesDoNotLinkUnrelatedFiles() throws {
        let split = try self.split([
            GeneratedSource(path: "Entities/Build.swift", contents: """
            public struct Build: Codable {
            \tpublic var attributes: Attributes?
            \tpublic struct Attributes: Codable {}
            }
            """),
            GeneratedSource(path: "Entities/AppStoreVersion.swift", contents: """
            public struct AppStoreVersion: Codable {
            \tpublic var attributes: Attributes?
            \tpublic struct Attributes: Codable {}
            }
            """),
            self.entity("BuildsResponse", references: ["Build"]),
            self.entity("AppStoreVersionsResponse", references: ["AppStoreVersion"]),
            self.path("PathsV1Builds", "/v1/builds", returns: "BuildsResponse"),
            self.path("PathsV1AppStoreVersions", "/v1/appStoreVersions", returns: "AppStoreVersionsResponse"),
        ])

        XCTAssertEqual(split.module(ofType: "Build"), "TestFlight")
        XCTAssertEqual(split.module(ofType: "AppStoreVersion"), "AppStore")
    }

    // MARK: - Endpoint placement

    func testNestedEndpointIsPlacedByTheResourceItReturnsNotByTheParentPath() throws {
        let split = try self.split([
            self.entity("BetaGroupsResponse"),
            self.entity("AppBetaGroupsLinkagesResponse"),
            self.path("PathsV1AppsWithIDBetaGroups", "/v1/apps/{id}/betaGroups", returns: "BetaGroupsResponse", operationID: "apps_betaGroups_getToManyRelated"),
            self.path("PathsV1AppsWithIDRelationshipsBetaGroups", "/v1/apps/{id}/relationships/betaGroups", returns: "AppBetaGroupsLinkagesResponse", operationID: "apps_betaGroups_getToManyRelationship"),
        ], routing: SpecRouting(
            topLevelResourceTags: ["apps": "Apps", "betaGroups": "BetaGroups"],
            operationTags: ["apps_betaGroups_getToManyRelated": "Apps", "apps_betaGroups_getToManyRelationship": "Apps"]
        ))

        XCTAssertEqual(split.moduleByFile["Paths/PathsV1AppsWithIDBetaGroups.swift"], "TestFlight")
        XCTAssertEqual(split.moduleByFile["Paths/PathsV1AppsWithIDRelationshipsBetaGroups.swift"], "TestFlight")
    }

    func testEndpointWithoutTopLevelResourceFallsBackToItsOperationTag() throws {
        let split = try self.split([
            self.entity("AppPerfPowerMetrics"),
            self.path("PathsV1AppsWithIDPerfPowerMetrics", "/v1/apps/{id}/perfPowerMetrics", returns: "AppPerfPowerMetrics", operationID: "apps_perfPowerMetrics_getToManyRelated"),
        ], routing: SpecRouting(
            topLevelResourceTags: ["apps": "Apps"],
            operationTags: ["apps_perfPowerMetrics_getToManyRelated": "GameCenterDetails"]
        ))

        XCTAssertEqual(split.moduleByFile["Paths/PathsV1AppsWithIDPerfPowerMetrics.swift"], "GameCenter")
    }

    func testRootPathNamespaceBelongsToCore() throws {
        let split = try self.split([
            GeneratedSource(path: "Paths/PathsV1.swift", contents: """
            extension APIEndpoint {
            \tpublic static var v1: V1 { V1(path: "/v1") }
            \tpublic struct V1 {
            \t\t/// Path: `/v1`
            \t\tpublic let path: String
            \t}
            }
            """),
        ])

        XCTAssertEqual(split.moduleByFile["Paths/PathsV1.swift"], "Core")
    }

    // MARK: - Configuration errors

    func testUnmappedTagFailsWithTheTagName() throws {
        let routing = SpecRouting(topLevelResourceTags: ["webhooks": "Webhooks"], operationTags: [:])

        XCTAssertThrowsError(try self.split([
            self.entity("WebhooksResponse"),
            self.path("PathsV1Webhooks", "/v1/webhooks", returns: "WebhooksResponse"),
        ], routing: routing)) { error in
            XCTAssertEqual(error as? ModuleSplitterError, .unmappedTags(["Webhooks"]))
        }
    }

    func testTagMappedToTwoAreasIsRejected() {
        let config = ModuleSplitConfig(core: "Core", areas: ["AppStore": ["Apps"], "TestFlight": ["Apps"]])

        XCTAssertThrowsError(try ModuleSplitter.split(sources: [], routing: self.routing, config: config)) { error in
            XCTAssertEqual(error as? ModuleSplitterError, .tagMappedMoreThanOnce(tag: "Apps", areas: ["AppStore", "TestFlight"]))
        }
    }

    func testConfigCoversEveryTagInTheSpecIsCheckedOnTheSpecNotOnlyOnUsedEndpoints() throws {
        let routing = SpecRouting(
            topLevelResourceTags: ["builds": "Builds"],
            operationTags: ["unusedThing_get": "UnusedThings"]
        )

        XCTAssertThrowsError(try self.split([], routing: routing)) { error in
            XCTAssertEqual(error as? ModuleSplitterError, .unmappedTags(["UnusedThings"]))
        }
    }

    // MARK: - Determinism

    func testResultDoesNotDependOnInputOrder() throws {
        let sources = [
            self.entity("BuildsResponse", references: ["Build"]),
            self.entity("AppStoreVersionsResponse", references: ["AppStoreVersion"]),
            self.entity("AppStoreVersion", references: ["Build"]),
            self.entity("Build"),
            self.entity("Orphan"),
            self.entity("Orphan2"),
            self.path("PathsV1Builds", "/v1/builds", returns: "BuildsResponse"),
            self.path("PathsV1AppStoreVersions", "/v1/appStoreVersions", returns: "AppStoreVersionsResponse"),
        ]

        let forward = try self.split(sources)
        let reversed = try self.split(sources.reversed())

        XCTAssertEqual(forward, reversed)
        XCTAssertEqual(forward.report(), reversed.report())
    }

    // MARK: - Report

    func testReportCountsFilesAndLinesPerModuleLargestFirst() throws {
        let split = try self.split([
            self.entity("BuildsResponse", references: ["Build"]),
            GeneratedSource(path: "Entities/Build.swift", contents: "public struct Build {\n\tvar a: Int\n\tvar b: Int\n\tvar c: Int\n}\n"),
            self.entity("AppStoreVersionsResponse"),
            self.path("PathsV1Builds", "/v1/builds", returns: "BuildsResponse"),
            self.path("PathsV1AppStoreVersions", "/v1/appStoreVersions", returns: "AppStoreVersionsResponse"),
        ])

        let report = split.report()
        XCTAssertEqual(report.modules.map(\.name), ["TestFlight", "AppStore"])
        XCTAssertEqual(report.modules.map(\.files), [3, 2])
        XCTAssertEqual(report.totalLines, report.modules.map(\.lines).reduce(0, +))
        XCTAssertTrue(report.markdown.contains("| TestFlight |"))
    }

    func testModulesRequiredForEndpointsIncludeCore() throws {
        let split = try self.split([
            self.entity("BuildsResponse"),
            self.entity("AppStoreVersionsResponse"),
            self.entity("GameCenterDetailsResponse"),
            self.path("PathsV1Builds", "/v1/builds", returns: "BuildsResponse"),
            self.path("PathsV1AppStoreVersions", "/v1/appStoreVersions", returns: "AppStoreVersionsResponse"),
            self.path("PathsV1GameCenterDetails", "/v1/gameCenterDetails", returns: "GameCenterDetailsResponse"),
        ])

        XCTAssertEqual(split.modules(requiredForPaths: ["/v1/builds", "/v1/appStoreVersions"]), ["AppStore", "Core", "TestFlight"])
    }

    // MARK: - Spec + checked-in config

    func testRoutingIsReadFromTheSpec() throws {
        let spec = #"""
        {"paths": {
          "/v1/apps": {"get": {"tags": ["Apps"], "operationId": "apps_getCollection"}},
          "/v1/apps/{id}/betaGroups": {"get": {"tags": ["Apps"], "operationId": "apps_betaGroups_getToManyRelated"}, "parameters": []},
          "/v1/betaGroups": {"post": {"tags": ["BetaGroups"], "operationId": "betaGroups_createInstance"}}
        }}
        """#
        let routing = try SpecRouting(specJSON: Data(spec.utf8))

        XCTAssertEqual(routing.topLevelResourceTags, ["apps": "Apps", "betaGroups": "BetaGroups"])
        XCTAssertEqual(routing.operationTags["apps_betaGroups_getToManyRelated"], "Apps")
    }

    func testCheckedInConfigMapsEveryTagOfTheCheckedInSpec() throws {
        let openAPI = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent("Sources/OpenAPI")
        let config = try ModuleSplitConfig.load(from: openAPI.appendingPathComponent("modules.json"))
        let routing = try SpecRouting(specJSON: Data(contentsOf: openAPI.appendingPathComponent("app_store_connect_api.json")))

        XCTAssertNoThrow(try ModuleSplitter.split(sources: [], routing: routing, config: config))
    }

    // MARK: - Helpers

    private func split(_ sources: [GeneratedSource], routing: SpecRouting? = nil) throws -> ModuleSplit {
        try ModuleSplitter.split(sources: sources, routing: routing ?? self.routing, config: self.config)
    }

    private func entity(_ name: String, references: [String] = []) -> GeneratedSource {
        let properties = references.enumerated().map { "\tpublic var p\($0.offset): \($0.element)?" }.joined(separator: "\n")
        return GeneratedSource(path: "Entities/\(name).swift", contents: "public struct \(name): Codable {\n\(properties)\n}\n")
    }

    private func path(_ file: String, _ path: String, returns response: String, operationID: String = "op") -> GeneratedSource {
        GeneratedSource(path: "Paths/\(file).swift", contents: """
        extension APIEndpoint.V1 {
        \tpublic struct Node {
        \t\t/// Path: `\(path)`
        \t\tpublic let path: String

        \t\tpublic var get: Request<AppStoreConnect_Swift_SDK.\(response)> {
        \t\t\tRequest(path: path, method: "GET", id: "\(operationID)")
        \t\t}
        \t}
        }
        """)
    }
}

private extension ModuleSplit {
    func module(ofType name: String) -> String? {
        self.moduleByFile["Entities/\(name).swift"]
    }
}
#endif
