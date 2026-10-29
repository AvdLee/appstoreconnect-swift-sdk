#if os(macOS)
import Foundation
import XCTest
@testable import OpenAPIGeneratorCore

final class GeneratedPatchingTests: XCTestCase {
    func testCheckedInGeneratedSourcesHaveAllPatches() throws {
        let packageRoot = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
        let generatedRoot = packageRoot.appendingPathComponent("Sources/OpenAPI/Generated")

        let report = try GeneratedPatcher.patchGeneratedSources(atRoot: generatedRoot, dryRun: true)
        XCTAssertTrue(report.changedFiles.isEmpty, "Generated sources still need patches: \(report.changes)")
        XCTAssertTrue(report.missingFiles.isEmpty, "Missing generated files: \(report.missingFiles)")
    }

    func testPatchesFreshlyGeneratedMetricAndPlacementSources() throws {
        let root = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        let entities = root.appendingPathComponent("Entities")
        try FileManager.default.createDirectory(at: entities, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: root) }

        let metricSource = """
        public var links: PagedDocumentLinks
        public var meta: PagingInformation?
        public var data: String?
        public init(links: Links? = nil, data: String? = nil)
        self.data = try values.decodeIfPresent(String.self, forKey: "data")
        """
        try metricSource.write(
            to: entities.appendingPathComponent("BetaTesterUsagesV1MetricResponse.swift"),
            atomically: true, encoding: .utf8
        )
        try metricSource.write(
            to: entities.appendingPathComponent("AppsBetaTesterUsagesV1MetricResponse.swift"),
            atomically: true, encoding: .utf8
        )
        try "public enum AppAssetLibraryPlacementState: String, Codable, CaseIterable {\n\tcase assetProcessing = \"ASSET_PROCESSING\"\n\tcase parentApproved = \"PARENT_APPROVED\"\n}"
            .write(to: entities.appendingPathComponent("AppAssetLibraryPlacementState.swift"), atomically: true, encoding: .utf8)

        let placementSource = """

\t\t\tstruct Discriminator: Decodable {
\t\t\t\tlet mediaType: String
\t\t\t}

\t\t\tlet container = try decoder.singleValueContainer()
\t\t\tlet discriminatorValue = try container.decode(Discriminator.self).mediaType

\t\t\tswitch discriminatorValue {
\t\t\tcase "IMAGE": self = .appAssetLibraryPlacementImageRelationships(try container.decode(AppAssetLibraryPlacementImageRelationships.self))
\t\t\tcase "VIDEO": self = .appAssetLibraryPlacementVideoRelationships(try container.decode(AppAssetLibraryPlacementVideoRelationships.self))

\t\t\tdefault:
\t\t\t\tthrow DecodingError.dataCorruptedError(
\t\t\t\t\tin: container,
\t\t\t\t\tdebugDescription: "Discriminator value '\\(discriminatorValue)' does not match any expected values (IMAGE, VIDEO)."
\t\t\t\t)
\t\t\t}
"""
        try placementSource.write(
            to: entities.appendingPathComponent("AppAssetLibraryPlacement.swift"),
            atomically: true, encoding: .utf8
        )

        let first = try GeneratedPatcher.patchGeneratedSources(atRoot: root)
        XCTAssertEqual(first.changedFiles.count, 4)
        let patchedMetric = try String(
            contentsOf: entities.appendingPathComponent("AppsBetaTesterUsagesV1MetricResponse.swift"),
            encoding: .utf8
        )
        XCTAssertTrue(patchedMetric.contains("public var data: MetricDimensionData?"))
        XCTAssertTrue(patchedMetric.contains("public var links: PagedDocumentLinks"))
        XCTAssertTrue(patchedMetric.contains("public var meta: PagingInformation?"))
        let patchedPlacementState = try String(
            contentsOf: entities.appendingPathComponent("AppAssetLibraryPlacementState.swift"), encoding: .utf8
        )
        XCTAssertTrue(patchedPlacementState.contains(#"case active = "ACTIVE""#))
        XCTAssertTrue(patchedPlacementState.contains(#"case inactive = "INACTIVE""#))
        let second = try GeneratedPatcher.patchGeneratedSources(atRoot: root)
        XCTAssertTrue(second.changedFiles.isEmpty)
    }

    func testPatchesPlacementStateThatAlreadyIncludesActive() throws {
        let root = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        let entities = root.appendingPathComponent("Entities")
        try FileManager.default.createDirectory(at: entities, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: root) }
        let file = entities.appendingPathComponent("AppAssetLibraryPlacementState.swift")
        let source = "public enum AppAssetLibraryPlacementState: String, Codable, CaseIterable {\n\tcase active = \"ACTIVE\"\n\tcase assetProcessing = \"ASSET_PROCESSING\"\n\tcase parentApproved = \"PARENT_APPROVED\"\n}\n"
        try source.write(to: file, atomically: true, encoding: .utf8)

        let preview = try GeneratedPatcher.patchGeneratedSources(atRoot: root, dryRun: true)
        XCTAssertEqual(preview.changedFiles.count, 1)
        XCTAssertEqual(try String(contentsOf: file, encoding: .utf8), source)
        let first = try GeneratedPatcher.patchGeneratedSources(atRoot: root)
        XCTAssertEqual(first.changedFiles.count, 1)
        let patched = try String(contentsOf: file, encoding: .utf8)
        XCTAssertTrue(patched.contains(#"case inactive = "INACTIVE""#))
        XCTAssertEqual(patched.components(separatedBy: #"case active = "ACTIVE""#).count, 2)
        XCTAssertEqual(patched.components(separatedBy: #"case inactive = "INACTIVE""#).count, 2)
        let second = try GeneratedPatcher.patchGeneratedSources(atRoot: root)
        XCTAssertTrue(second.changedFiles.isEmpty)
    }

    func testPatchesCiGitUserAvatarURLToString() throws {
        let tmp = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString, isDirectory: true)
        try FileManager.default.createDirectory(at: tmp, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: tmp) }

        let entities = tmp.appendingPathComponent("Entities", isDirectory: true)
        try FileManager.default.createDirectory(at: entities, withIntermediateDirectories: true)

        let file = entities.appendingPathComponent("CiGitUser.swift")
        try """
        import Foundation

        public struct CiGitUser: Codable {
        \tpublic var displayName: String?
        \tpublic var avatarURL: URL?

        \tpublic init(displayName: String? = nil, avatarURL: URL? = nil) {
        \t\tself.displayName = displayName
        \t\tself.avatarURL = avatarURL
        \t}

        \tpublic init(from decoder: Decoder) throws {
        \t\tlet values = try decoder.container(keyedBy: StringCodingKey.self)
        \t\tself.displayName = try values.decodeIfPresent(String.self, forKey: "displayName")
        \t\tself.avatarURL = try values.decodeIfPresent(URL.self, forKey: "avatarUrl")
        \t}
        }
        """.write(to: file, atomically: true, encoding: .utf8)

        let report = try GeneratedPatcher.patchGeneratedSources(atRoot: tmp, dryRun: false)
        XCTAssertEqual(report.changedFiles.count, 1)

        let out = try String(contentsOf: file, encoding: .utf8)
        XCTAssertTrue(out.contains("public var avatarURL: String?"))
        XCTAssertTrue(out.contains("avatarURL: String? = nil"))
        XCTAssertTrue(out.contains(#"decodeIfPresent(String.self, forKey: "avatarUrl")"#))

        let secondReport = try GeneratedPatcher.patchGeneratedSources(atRoot: tmp, dryRun: false)
        XCTAssertTrue(secondReport.changedFiles.isEmpty)
        XCTAssertEqual(secondReport.alreadyPresent.count, 3)
        XCTAssertTrue(secondReport.missingFiles.contains("CiBuildRun.swift"))
    }
}
#endif


