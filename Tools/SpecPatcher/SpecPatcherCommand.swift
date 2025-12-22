import Foundation
import ArgumentParser
import SpecPatching

@main
struct SpecPatcherCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Applies structure-aware post-processing fixes to an OpenAPI JSON spec."
    )

    @Option(help: "Path to the input OpenAPI JSON file.")
    var input: String

    @Option(help: "Path to write the patched JSON. Defaults to overwriting input unless --in-place is set.")
    var output: String?

    @Flag(help: "Overwrite the input file.")
    var inPlace: Bool = false

    @Flag(help: "Suppress human-readable output.")
    var quiet: Bool = false

    @Flag(help: "Do not write output (only report what would change).")
    var dryRun: Bool = false

    @Flag(help: "Exit with a non-zero code if any patch would be applied. Useful to detect when upstream is fixed.")
    var check: Bool = false

    @Flag(help: "Treat missing patch targets as an error (prevents false 'upstream fixed' when the spec shape changed).")
    var strict: Bool = false

    mutating func run() throws {
        let resolvedOutput: String = {
            if inPlace { return input }
            if let output { return output }
            return input // default: overwrite (convenient for CI)
        }()

        let inputURL = URL(fileURLWithPath: input)
        let outputURL = URL(fileURLWithPath: resolvedOutput)

        let data = try Data(contentsOf: inputURL)
        let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
        guard var root = json as? [String: Any] else {
            throw ValidationError("Spec root must be a JSON object")
        }

        let result = try SpecPatcher.patch(&root)

        if !dryRun {
            let outData = try JSONSerialization.data(withJSONObject: root, options: [.prettyPrinted, .withoutEscapingSlashes])
            try outData.write(to: outputURL, options: [.atomic])
        }

        if !quiet {
            for r in result.rules {
                let status: String
                if r.matchCount == 0 {
                    status = "unknown (no matches; spec shape changed?)"
                } else if r.didChange {
                    status = "needs patch (upstream not fixed)"
                } else {
                    status = "already satisfied (likely fixed upstream)"
                }
                print("[\(r.id.rawValue)] \(status) (matches: \(r.matchCount))")
            }

            if result.didChange {
                print("Patched spec (\(result.changes.count) changes).")
            } else {
                print("No changes needed.")
            }
        }

        if check {
            // Non-zero when any patch is still needed.
            if result.didChange {
                throw ExitCode(2)
            }
            // In strict mode, any "unknown" (matchCount==0) should fail too (maintenance required).
            if strict, result.rules.contains(where: { $0.matchCount == 0 }) {
                throw ExitCode(3)
            }
        }
    }
}


