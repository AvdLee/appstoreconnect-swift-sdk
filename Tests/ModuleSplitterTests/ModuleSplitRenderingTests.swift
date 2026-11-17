#if os(macOS)
import Foundation
import XCTest
@testable import OpenAPIGeneratorCore

/// Renders a small generated tree into modules. `/v1/apps/{id}` belongs to AppStore but is extended by
/// `/v1/apps/{id}/betaGroups`, which belongs to TestFlight: the case that forces namespace shells into Core.
final class ModuleSplitRenderingTests: XCTestCase {
    private let config = ModuleSplitConfig(
        core: "Core",
        areas: ["AppStore": ["Apps"], "TestFlight": ["Builds", "BetaGroups"]]
    )
    private let routing = SpecRouting(
        topLevelResourceTags: ["apps": "Apps", "builds": "Builds", "betaGroups": "BetaGroups"],
        operationTags: [:]
    )

    // MARK: - Layout

    func testFilesLandInTheirModuleFolders() throws {
        let rendered = try self.render()

        XCTAssertNotNil(rendered["Core/Paths/PathsV1.swift"])
        XCTAssertNotNil(rendered["Core/Extensions/StringCodingKey.swift"])
        XCTAssertNotNil(rendered["AppStore/Entities/App.swift"])
        XCTAssertNotNil(rendered["TestFlight/Entities/Build.swift"])
        XCTAssertNotNil(rendered["TestFlight/Paths/PathsV1Builds.swift"])
        XCTAssertNotNil(rendered["TestFlight/Paths/PathsV1AppsWithIDBetaGroups.swift"])
    }

    func testTypesUsedByHandWrittenCoreCodeStayInCore() throws {
        let rendered = try self.render()

        // Nothing generated reaches ErrorResponse, but APIProvider does.
        XCTAssertNotNil(rendered["Core/Entities/ErrorResponse.swift"])
        XCTAssertNotNil(rendered["Core/Entities/ErrorLinks.swift"])
    }

    func testEveryFileNameIsUniqueSoTheSingleModuleBuildStillCompiles() throws {
        let rendered = try self.render()
        let names = rendered.keys.map { URL(fileURLWithPath: $0).lastPathComponent }

        XCTAssertEqual(Set(names).count, names.count, "Duplicate file names: \(names.sorted())")
    }

    // MARK: - Namespace shells

    func testNodeExtendedFromAnotherModuleIsSplitIntoCoreShellAndAreaOperations() throws {
        let rendered = try self.render()

        let shell = try XCTUnwrap(rendered["Core/Namespaces/PathsV1AppsWithID+Namespace.swift"])
        XCTAssertTrue(shell.contains("extension APIEndpoint.V1.Apps {"))
        XCTAssertTrue(shell.contains("\tpublic func id(_ id: String) -> WithID {"))
        XCTAssertTrue(shell.contains("\tpublic struct WithID: Sendable {"))
        XCTAssertTrue(shell.contains("\t\tpublic let path: String"))
        XCTAssertFalse(shell.contains("func get"))
        XCTAssertFalse(shell.contains("AppResponse"))

        let operations = try XCTUnwrap(rendered["AppStore/Paths/PathsV1AppsWithID.swift"])
        XCTAssertTrue(operations.contains("extension APIEndpoint.V1.Apps.WithID {"))
        XCTAssertTrue(operations.contains("\t/// Path: `/v1/apps/{id}`"))
        XCTAssertTrue(operations.contains("\tpublic func get() -> Request<AppResponse> {"))
        XCTAssertFalse(operations.contains("public let path"))
        XCTAssertFalse(operations.contains("public struct WithID"))
    }

    func testAncestorsOfAShelledNodeAreShelledToo() throws {
        let rendered = try self.render()

        // Core's WithID shell extends APIEndpoint.V1.Apps, so Apps must be declared in Core as well.
        XCTAssertNotNil(rendered["Core/Namespaces/PathsV1Apps+Namespace.swift"])
        XCTAssertTrue(try XCTUnwrap(rendered["AppStore/Paths/PathsV1Apps.swift"]).contains("extension APIEndpoint.V1.Apps {"))
    }

    func testNodeOnlyExtendedWithinItsModuleIsNotSplit() throws {
        let rendered = try self.render()

        XCTAssertNil(rendered["Core/Namespaces/PathsV1Builds+Namespace.swift"])
        XCTAssertTrue(try XCTUnwrap(rendered["TestFlight/Paths/PathsV1Builds.swift"]).contains("\tpublic struct Builds: Sendable {"))
    }

    // MARK: - Source rewrites

    func testModuleQualifiersAreRemoved() throws {
        let rendered = try self.render()

        for (path, contents) in rendered {
            XCTAssertFalse(contents.contains("AppStoreConnect_Swift_SDK."), path)
        }
        XCTAssertTrue(try XCTUnwrap(rendered["TestFlight/Paths/PathsV1Builds.swift"]).contains("Request<BuildsResponse>"))
    }

    func testAreaFilesImportCoreOnlyWhenItExists() throws {
        let rendered = try self.render()
        let guardedImport = "#if canImport(AppStoreConnectCore)\n@_spi(Internal) import AppStoreConnectCore\n#endif\n"

        let area = try XCTUnwrap(rendered["TestFlight/Paths/PathsV1Builds.swift"])
        XCTAssertTrue(area.contains("import URLQueryEncoder\n" + guardedImport), area)
        XCTAssertTrue(try XCTUnwrap(rendered["AppStore/Entities/App.swift"]).contains(guardedImport))
        XCTAssertFalse(try XCTUnwrap(rendered["Core/Paths/PathsV1.swift"]).contains("AppStoreConnectCore"))
    }

    func testStringCodingKeyIsVisibleToAreaModulesAsSPI() throws {
        let key = try XCTUnwrap(try self.render()["Core/Extensions/StringCodingKey.swift"])

        XCTAssertTrue(key.contains("@_spi(Internal) public struct StringCodingKey: CodingKey, ExpressibleByStringLiteral {"))
        for member in ["public var stringValue", "public init(string:", "public init?(stringValue:", "public var intValue", "public init?(intValue:", "public init(stringLiteral"] {
            XCTAssertTrue(key.contains(member), member)
        }
        XCTAssertTrue(key.contains("\tprivate let string: String"))
    }

    func testUmbrellaReExportsEveryModule() throws {
        let exports = try XCTUnwrap(try self.render()["Umbrella/Exports.swift"])

        for module in ["AppStoreConnectCore", "AppStoreConnectAppStore", "AppStoreConnectTestFlight"] {
            XCTAssertTrue(exports.contains("#if canImport(\(module))\n@_exported import \(module)\n#endif"), module)
        }
    }

    // MARK: - Round trip

    func testPlanningTheRenderedTreeReproducesTheSameSplit() throws {
        let split = try self.plan()
        let rendered = try ModuleSplitter.render(sources: self.sources, split: split, config: self.config)

        let replanned = try ModuleSplitter.split(
            sources: ModuleSplitter.unrender(rendered, config: self.config),
            coreSources: self.coreSources,
            routing: self.routing,
            config: self.config
        )

        XCTAssertEqual(replanned.moduleByFile, split.moduleByFile)
    }

    // MARK: - Fixture

    private func plan() throws -> ModuleSplit {
        try ModuleSplitter.split(sources: self.sources, coreSources: self.coreSources, routing: self.routing, config: self.config)
    }

    private func render() throws -> [String: String] {
        let rendered = try ModuleSplitter.render(sources: self.sources, split: self.plan(), config: self.config)
        return Dictionary(uniqueKeysWithValues: rendered.map { ($0.path, $0.contents) })
    }

    private let coreSources = [
        GeneratedSource(path: "APIProvider.swift", contents: "public final class APIProvider {\n\tvar error: ErrorResponse?\n}\n"),
    ]

    private var sources: [GeneratedSource] {
        [
            GeneratedSource(path: "Extensions/StringCodingKey.swift", contents: """
            import Foundation

            struct StringCodingKey: CodingKey, ExpressibleByStringLiteral {
            \tprivate let string: String
            \tprivate var int: Int?

            \tvar stringValue: String { return string }

            \tinit(string: String) {
            \t\tself.string = string
            \t}

            \tinit?(stringValue: String) {
            \t\tself.string = stringValue
            \t}

            \tvar intValue: Int? { return int }

            \tinit?(intValue: Int) {
            \t\tself.string = String(describing: intValue)
            \t\tself.int = intValue
            \t}

            \tinit(stringLiteral value: String) {
            \t\tself.string = value
            \t}
            }

            """),
            self.entity("App"),
            self.entity("AppsResponse", references: ["App"]),
            self.entity("AppResponse", references: ["App"]),
            self.entity("Build"),
            self.entity("BuildsResponse", references: ["Build"]),
            self.entity("BetaGroupsResponse"),
            self.entity("ErrorResponse", references: ["ErrorLinks"]),
            self.entity("ErrorLinks"),
            GeneratedSource(path: "Paths/PathsV1.swift", contents: """
            import Foundation
            import URLQueryEncoder

            extension APIEndpoint {
            \tpublic static var v1: V1 {
            \t\tV1(path: "/v1")
            \t}

            \tpublic struct V1: Sendable {
            \t\t/// Path: `/v1`
            \t\tpublic let path: String
            \t}
            }

            """),
            self.path("PathsV1Apps", parent: "APIEndpoint.V1", accessor: "public var apps: Apps {\n\t\tApps(path: path + \"/apps\")\n\t}", node: "Apps", path: "/v1/apps", returns: "AppsResponse"),
            self.path("PathsV1AppsWithID", parent: "APIEndpoint.V1.Apps", accessor: "public func id(_ id: String) -> WithID {\n\t\tWithID(path: \"\\(path)/\\(id)\")\n\t}", node: "WithID", path: "/v1/apps/{id}", returns: "AppResponse"),
            self.path("PathsV1AppsWithIDBetaGroups", parent: "APIEndpoint.V1.Apps.WithID", accessor: "public var betaGroups: BetaGroups {\n\t\tBetaGroups(path: path + \"/betaGroups\")\n\t}", node: "BetaGroups", path: "/v1/apps/{id}/betaGroups", returns: "BetaGroupsResponse"),
            self.path("PathsV1Builds", parent: "APIEndpoint.V1", accessor: "public var builds: Builds {\n\t\tBuilds(path: path + \"/builds\")\n\t}", node: "Builds", path: "/v1/builds", returns: "BuildsResponse"),
        ]
    }

    private func entity(_ name: String, references: [String] = []) -> GeneratedSource {
        let properties = references.map { "\tpublic var \($0.lowercased()): AppStoreConnect_Swift_SDK.\($0)?\n" }.joined()
        return GeneratedSource(path: "Entities/\(name).swift", contents: "import Foundation\n\npublic struct \(name): Codable, Sendable {\n\(properties)}\n")
    }

    private func path(_ file: String, parent: String, accessor: String, node: String, path: String, returns response: String) -> GeneratedSource {
        GeneratedSource(path: "Paths/\(file).swift", contents: """
        // Generated by Create API
        // https://github.com/CreateAPI/CreateAPI

        import Foundation
        import URLQueryEncoder

        extension \(parent) {
        \t\(accessor)

        \tpublic struct \(node): Sendable {
        \t\t/// Path: `\(path)`
        \t\tpublic let path: String

        \t\tpublic func get() -> Request<AppStoreConnect_Swift_SDK.\(response)> {
        \t\t\tRequest(path: path, method: "GET", id: "\(file)_get")
        \t\t}
        \t}
        }

        """)
    }
}
#endif
