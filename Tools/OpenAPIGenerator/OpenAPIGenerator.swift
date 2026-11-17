import ArgumentParser
import Foundation
import OpenAPIGeneratorCore

@main
struct OpenAPIGenerator: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Downloads, patches, generates, and post-processes the App Store Connect OpenAPI SDK sources.",
        subcommands: [Download.self, Generate.self, Update.self, SplitReport.self]
    )

    struct Download: AsyncParsableCommand {
        static let configuration = CommandConfiguration(abstract: "Download Apple’s OpenAPI spec zip, extract JSON, and patch it.")

        @Option(help: "Path to write the OpenAPI JSON spec.")
        var specPath: String?

        @Option(help: "Override the source zip URL.")
        var sourceZipURL: String = "https://developer.apple.com/sample-code/app-store-connect/app-store-connect-openapi-specification.zip"

        @Flag(help: "Print per-rule status.")
        var verbose: Bool = false

        @Option(help: "Network timeout (seconds) for downloading the zip.")
        var timeoutSeconds: Double = 120

        mutating func run() async throws {
            let root = try OpenAPIGeneratorCore.findPackageRoot()
            let paths = OpenAPIGeneratorPaths(packageRoot: root)
            let specURL = URL(fileURLWithPath: specPath ?? paths.specJSON.path)

            guard let zipURL = URL(string: sourceZipURL) else {
                throw ValidationError("Invalid --source-zip-url")
            }

            func log(_ s: String) {
                // stderr is unbuffered in most contexts; this helps users see progress immediately.
                FileHandle.standardError.write((s + "\n").data(using: .utf8)!)
            }

            log("OpenAPIGenerator: starting download…")
            let result = try await OpenAPIGeneratorCore.downloadAndPatchSpec(
                specURL: specURL,
                sourceZipURL: zipURL,
                timeoutSeconds: timeoutSeconds,
                log: log
            )
            print("Wrote spec: \(specURL.path)")
            if verbose {
                for r in result.rules {
                    let status: String
                    if r.matchCount == 0 {
                        status = r.zeroMatchesIsOK ? "already satisfied (no matches)" : "unknown (no matches)"
                    } else if r.didChange {
                        status = "needs patch"
                    } else {
                        status = "already satisfied"
                    }
                    print("[\(r.id.rawValue)] \(status) (matches: \(r.matchCount))")
                }
            }
            print(result.didChange ? "Patched spec (\(result.changes.count) changes)." : "No spec changes needed.")
        }
    }

    struct Generate: ParsableCommand {
        static let configuration = CommandConfiguration(abstract: "Generate Swift sources from the spec and patch the generated code.")

        @Option(help: "Path to the generated sources root (folder containing Entities/ and Paths/).")
        var generatedRoot: String?

        mutating func run() throws {
            let root = try OpenAPIGeneratorCore.findPackageRoot()
            let paths = OpenAPIGeneratorPaths(packageRoot: root)
            let generatedURL = URL(fileURLWithPath: generatedRoot ?? paths.generatedRoot.path)

            let report = try OpenAPIGeneratorCore.generateAndPatchGenerated(packageRoot: root, generatedRoot: generatedURL)
            if report.changedFiles.isEmpty {
                print("No generated code changes needed.")
            } else {
                print("Patched generated code (\(report.changedFiles.count) files, \(report.changes.count) changes):")
                for c in report.changes { print("- \(c)") }
            }
            for change in report.alreadyPresent {
                print("[generated] already present; review patch: \(change)")
            }
            for file in report.missingFiles {
                print("[generated] target file missing; review patch: \(file)")
            }
        }
    }

    struct SplitReport: ParsableCommand {
        static let configuration = CommandConfiguration(
            commandName: "split-report",
            abstract: "Report how the generated sources would split into modules (from Sources/OpenAPI/modules.json). Changes no files."
        )

        @Option(help: "Directory to write split-report.md and split-report.json to.")
        var outputDir: String?

        @Option(name: .customLong("path"), help: "API path a consumer calls, e.g. /v1/builds. Repeat to list the modules a set of endpoints needs.")
        var apiPaths: [String] = []

        mutating func run() throws {
            let root = try OpenAPIGeneratorCore.findPackageRoot()
            let split = try OpenAPIGeneratorCore.planModuleSplit(paths: OpenAPIGeneratorPaths(packageRoot: root))
            let report = split.report()

            var markdown = report.markdown
            if !self.apiPaths.isEmpty {
                let unknown = self.apiPaths.filter { split.fileByAPIPath[$0] == nil }
                guard unknown.isEmpty else {
                    throw ValidationError("Unknown API paths: \(unknown.joined(separator: ", "))")
                }
                markdown += "\nModules needed for \(self.apiPaths.joined(separator: ", ")): \(split.modules(requiredForPaths: self.apiPaths).joined(separator: ", "))\n"
            }
            print(markdown)

            if let outputDir = self.outputDir {
                let directory = URL(fileURLWithPath: outputDir)
                try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
                try markdown.write(to: directory.appendingPathComponent("split-report.md"), atomically: true, encoding: .utf8)
                let encoder = JSONEncoder()
                encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
                try encoder.encode(report).write(to: directory.appendingPathComponent("split-report.json"))
            }
        }
    }

    struct Update: AsyncParsableCommand {
        static let configuration = CommandConfiguration(abstract: "Run download + generate.")

        @Option(help: "Path to write the OpenAPI JSON spec.")
        var specPath: String?

        @Option(help: "Path to the generated sources root (folder containing Entities/ and Paths/).")
        var generatedRoot: String?

        @Option(help: "Override the source zip URL.")
        var sourceZipURL: String = "https://developer.apple.com/sample-code/app-store-connect/app-store-connect-openapi-specification.zip"

        mutating func run() async throws {
            let root = try OpenAPIGeneratorCore.findPackageRoot()
            let paths = OpenAPIGeneratorPaths(packageRoot: root)

            let specURL = URL(fileURLWithPath: specPath ?? paths.specJSON.path)
            let generatedURL = URL(fileURLWithPath: generatedRoot ?? paths.generatedRoot.path)
            guard let zipURL = URL(string: sourceZipURL) else {
                throw ValidationError("Invalid --source-zip-url")
            }

            let specResult = try await OpenAPIGeneratorCore.downloadAndPatchSpec(specURL: specURL, sourceZipURL: zipURL)
            print("Wrote spec: \(specURL.path)")
            print(specResult.didChange ? "Patched spec (\(specResult.changes.count) changes)." : "No spec changes needed.")

            let report = try OpenAPIGeneratorCore.generateAndPatchGenerated(packageRoot: root, generatedRoot: generatedURL)
            if report.changedFiles.isEmpty {
                print("No generated code changes needed.")
            } else {
                print("Patched generated code (\(report.changedFiles.count) files, \(report.changes.count) changes):")
                for c in report.changes { print("- \(c)") }
            }
            for change in report.alreadyPresent {
                print("[generated] already present; review patch: \(change)")
            }
            for file in report.missingFiles {
                print("[generated] target file missing; review patch: \(file)")
            }
        }
    }
}

