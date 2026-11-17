#if os(macOS)
import Foundation
import XCTest
@testable import OpenAPIGeneratorCore

final class PackageManifestTests: XCTestCase {
    private let packageRoot = URL(fileURLWithPath: #filePath)
        .deletingLastPathComponent()
        .deletingLastPathComponent()
        .deletingLastPathComponent()

    /// Adding an area to modules.json without a target (or the reverse) leaves its sources unbuilt or a target empty.
    func testManifestDeclaresExactlyTheAreasOfTheModuleConfig() throws {
        let manifest = try String(contentsOf: self.packageRoot.appendingPathComponent("Package.swift"), encoding: .utf8)
        let list = try XCTUnwrap(manifest.range(of: #"let areaModules = \[[^\]]*\]"#, options: .regularExpression))
        let declared = manifest[list]
            .split(separator: "\n")
            .compactMap { $0.split(separator: "\"").dropFirst().first.map(String.init) }
        let config = try ModuleSplitConfig.load(from: self.packageRoot.appendingPathComponent("Sources/OpenAPI/modules.json"))

        XCTAssertEqual(declared, config.areas.keys.sorted())
    }

    func testEveryAreaHasGeneratedSources() throws {
        let config = try ModuleSplitConfig.load(from: self.packageRoot.appendingPathComponent("Sources/OpenAPI/modules.json"))
        let generated = self.packageRoot.appendingPathComponent("Sources/OpenAPI/Generated")

        for module in config.allModules {
            let files = (FileManager.default.subpaths(atPath: generated.appendingPathComponent(module).path) ?? []).filter { $0.hasSuffix(".swift") }
            XCTAssertFalse(files.isEmpty, "\(module) has no generated sources")
        }
    }
}
#endif
