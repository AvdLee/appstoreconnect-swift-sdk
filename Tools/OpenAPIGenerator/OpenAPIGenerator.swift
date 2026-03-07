import ArgumentParser
import Foundation
import OpenAPIGeneratorCore

@main
struct OpenAPIGenerator: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Downloads, patches, generates, and post-processes the App Store Connect OpenAPI SDK sources.",
        subcommands: [Download.self, Generate.self, Update.self]
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
        }
    }
}


