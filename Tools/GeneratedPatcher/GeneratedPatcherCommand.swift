import ArgumentParser
import Foundation
import GeneratedPatching

@main
struct GeneratedPatcherCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Applies structure-aware post-processing fixes to CreateAPI-generated Swift sources."
    )

    @Option(help: "Root directory of the generated OpenAPI sources (the folder that contains Entities/ and Paths/).")
    var root: String

    @Flag(help: "Report changes but do not write files.")
    var dryRun: Bool = false

    @Flag(help: "Suppress human-readable output.")
    var quiet: Bool = false

    mutating func run() throws {
        let rootURL = URL(fileURLWithPath: root)
        let report = try GeneratedPatcher.patchGeneratedSources(atRoot: rootURL, dryRun: dryRun)

        if !quiet {
            if report.changedFiles.isEmpty {
                print("No generated code changes needed.")
            } else {
                print("Patched generated code (\(report.changedFiles.count) files, \(report.changes.count) changes):")
                for c in report.changes {
                    print("- \(c)")
                }
            }
        }
    }
}



