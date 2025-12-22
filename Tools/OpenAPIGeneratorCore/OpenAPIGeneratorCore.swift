import Foundation
import ZIPFoundation
import OrderedCollections

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public enum OpenAPIGeneratorCoreError: Error, CustomStringConvertible {
    case couldNotFindPackageRoot(start: String)
    case processFailed(executable: String, code: Int32, stderr: String)
    case downloadFailed(String)
    case unzipFailed(String)

    public var description: String {
        switch self {
        case .couldNotFindPackageRoot(let start):
            return "Could not locate Package.swift starting from: \(start)"
        case .processFailed(let executable, let code, let stderr):
            return "Process failed (\(executable)) exit=\(code): \(stderr)"
        case .downloadFailed(let msg):
            return "Download failed: \(msg)"
        case .unzipFailed(let msg):
            return "Unzip failed: \(msg)"
        }
    }
}

public struct OpenAPIGeneratorPaths {
    public var packageRoot: URL
    public var specJSON: URL
    public var generatedRoot: URL

    public init(packageRoot: URL) {
        self.packageRoot = packageRoot
        self.specJSON = packageRoot.appendingPathComponent("Sources/OpenAPI/app_store_connect_api.json")
        self.generatedRoot = packageRoot.appendingPathComponent("Sources/OpenAPI/Generated")
    }
}

public enum OpenAPIGeneratorCore {
    /// Finds the package root by walking up until `Package.swift` is found.
    public static func findPackageRoot(from start: URL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)) throws -> URL {
        var url = start.standardizedFileURL
        let fm = FileManager.default

        while true {
            if fm.fileExists(atPath: url.appendingPathComponent("Package.swift").path) {
                return url
            }
            let parent = url.deletingLastPathComponent()
            if parent.path == url.path {
                throw OpenAPIGeneratorCoreError.couldNotFindPackageRoot(start: start.path)
            }
            url = parent
        }
    }

    /// Downloads Apple’s zip and extracts the JSON spec, then patches it in-place.
    public static func downloadAndPatchSpec(
        specURL: URL,
        sourceZipURL: URL = URL(string: "https://developer.apple.com/sample-code/app-store-connect/app-store-connect-openapi-specification.zip")!,
        timeoutSeconds: TimeInterval = 120,
        log: ((String) -> Void)? = nil
    ) async throws -> SpecPatcher.Result {
        let tmpZip = FileManager.default.temporaryDirectory.appendingPathComponent("asc-openapi-\(UUID().uuidString).zip")
        defer { try? FileManager.default.removeItem(at: tmpZip) }

        log?("Downloading spec zip…")
        try await download(url: sourceZipURL, to: tmpZip, timeoutSeconds: timeoutSeconds)
        log?("Downloaded zip to: \(tmpZip.path)")

        log?("Extracting JSON from zip…")
        let jsonData = try unzipSingleFileToData(zipURL: tmpZip)
        log?("Extracted JSON (\(jsonData.count) bytes)")

        log?("Patching + writing spec…")
        return try patchSpecJSON(jsonData, writingTo: specURL)
    }

    public static func patchSpec(at specURL: URL) throws -> SpecPatcher.Result {
        let data = try Data(contentsOf: specURL)
        return try patchSpecJSON(data, writingTo: specURL)
    }

    public static func generateAndPatchGenerated(
        packageRoot: URL,
        generatedRoot: URL
    ) throws -> GeneratedPatchReport {
        // Run the SwiftPM plugin (same as the Makefile).
        _ = try runProcess(
            executable: "/usr/bin/env",
            arguments: ["swift", "package", "--allow-writing-to-package-directory", "generate-open-api"],
            currentDirectory: packageRoot
        )

        return try GeneratedPatcher.patchGeneratedSources(atRoot: generatedRoot, dryRun: false)
    }

    // MARK: - Internals
    
    private static func patchSpecJSON(_ jsonData: Data, writingTo specURL: URL) throws -> SpecPatcher.Result {
        var root = try JSONDecoder().decode(JSONValue.self, from: jsonData)
        let upstreamResult = try SpecPatcher.patch(&root)
        let outData = try JSONEncoder().encode(root)
        try outData.write(to: specURL, options: [.atomic])
        return upstreamResult
    }

    private static func download(url: URL, to fileURL: URL, timeoutSeconds: TimeInterval) async throws {
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: timeoutSeconds)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw OpenAPIGeneratorCoreError.downloadFailed("Unexpected response for \(url.absoluteString)")
        }
        try data.write(to: fileURL, options: [.atomic])
    }

    private static func unzipSingleFileToData(zipURL: URL) throws -> Data {
        do {
            let archive = try Archive(url: zipURL, accessMode: .read)

            // Prefer the canonical filename if present; otherwise pick the first .json.
            let entry =
                archive.first(where: { $0.path.hasSuffix("app_store_connect_api.json") })
                ?? archive.first(where: { $0.path.lowercased().hasSuffix(".json") })

            guard let entry else {
                throw OpenAPIGeneratorCoreError.unzipFailed("No .json file found in zip")
            }

            var out = Data()
            out.reserveCapacity(Int(entry.uncompressedSize))
            _ = try archive.extract(entry, consumer: { chunk in
                out.append(chunk)
            })
            return out
        } catch {
            throw OpenAPIGeneratorCoreError.unzipFailed("\(error)")
        }
    }

    @discardableResult
    private static func runProcess(
        executable: String,
        arguments: [String],
        currentDirectory: URL?
    ) throws -> Data {
        let p = Process()
        p.executableURL = URL(fileURLWithPath: executable)
        p.arguments = arguments
        if let currentDirectory {
            p.currentDirectoryURL = currentDirectory
        }

        let stdout = Pipe()
        let stderr = Pipe()
        p.standardOutput = stdout
        p.standardError = stderr

        try p.run()
        p.waitUntilExit()

        let outData = stdout.fileHandleForReading.readDataToEndOfFile()
        let errData = stderr.fileHandleForReading.readDataToEndOfFile()
        if p.terminationStatus != 0 {
            let err = String(data: errData, encoding: .utf8) ?? ""
            throw OpenAPIGeneratorCoreError.processFailed(
                executable: ([executable] + arguments).joined(separator: " "),
                code: p.terminationStatus,
                stderr: err
            )
        }
        return outData
    }
}


