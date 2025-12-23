#if os(macOS)
import Foundation
import XCTest
@testable import OpenAPIGeneratorCore

final class GeneratedPatchingTests: XCTestCase {
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
    }
}
#endif



