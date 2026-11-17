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
    public var modulesConfig: URL

    public init(packageRoot: URL) {
        self.packageRoot = packageRoot
        self.specJSON = packageRoot.appendingPathComponent("Sources/OpenAPI/app_store_connect_api.json")
        self.generatedRoot = packageRoot.appendingPathComponent("Sources/OpenAPI/Generated")
        self.modulesConfig = packageRoot.appendingPathComponent("Sources/OpenAPI/modules.json")
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
        // Apply schema corrections even when regenerating an existing local spec
        // without downloading it again first.
        _ = try patchSpec(at: OpenAPIGeneratorPaths(packageRoot: packageRoot).specJSON)
        // Run the SwiftPM plugin (same as the Makefile).
        _ = try runProcess(
            executable: "/usr/bin/env",
            arguments: ["swift", "package", "--allow-writing-to-package-directory", "generate-open-api"],
            currentDirectory: packageRoot
        )

        var report = try GeneratedPatcher.patchGeneratedSources(atRoot: generatedRoot, dryRun: false)
        var paths = OpenAPIGeneratorPaths(packageRoot: packageRoot)
        paths.generatedRoot = generatedRoot
        report.changes += try self.splitGeneratedSources(paths: paths)
        return report
    }

    /// Works out which module every generated file belongs to, without changing any file.
    /// Reads the flat tree CreateAPI writes, or the split tree if the sources were already split.
    public static func planModuleSplit(paths: OpenAPIGeneratorPaths) throws -> ModuleSplit {
        let config = try ModuleSplitConfig.load(from: paths.modulesConfig)
        let routing = try SpecRouting(specJSON: Data(contentsOf: paths.specJSON))
        let sources = try self.readGeneratedSources(paths: paths, config: config)
        return try ModuleSplitter.split(sources: sources, coreSources: self.readHandWrittenSources(paths: paths), routing: routing, config: config)
    }

    /// Moves the flat generated tree into one folder per module (see `ModuleSplitter.render`).
    /// Does nothing when the tree is already split.
    public static func splitGeneratedSources(paths: OpenAPIGeneratorPaths) throws -> [String] {
        let fileManager = FileManager.default
        guard fileManager.fileExists(atPath: paths.generatedRoot.appendingPathComponent("Entities").path) else {
            return ["Generated sources are already split into modules."]
        }
        let config = try ModuleSplitConfig.load(from: paths.modulesConfig)
        let routing = try SpecRouting(specJSON: Data(contentsOf: paths.specJSON))
        let sources = try self.readSwiftFiles(in: paths.generatedRoot)
        let split = try ModuleSplitter.split(sources: sources, coreSources: self.readHandWrittenSources(paths: paths), routing: routing, config: config)
        let rendered = try ModuleSplitter.render(sources: sources, split: split, config: config)

        for item in try fileManager.contentsOfDirectory(atPath: paths.generatedRoot.path) {
            try fileManager.removeItem(at: paths.generatedRoot.appendingPathComponent(item))
        }
        for file in rendered {
            let url = paths.generatedRoot.appendingPathComponent(file.path)
            try fileManager.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
            try file.contents.write(to: url, atomically: true, encoding: .utf8)
        }

        let report = split.report()
        return ["Split generated sources into \(report.modules.count) modules; \(report.core) holds \(report.modules.first { $0.name == report.core }?.files ?? 0) of \(sources.count) files."]
    }

    private static func readGeneratedSources(paths: OpenAPIGeneratorPaths, config: ModuleSplitConfig) throws -> [GeneratedSource] {
        let sources = try self.readSwiftFiles(in: paths.generatedRoot)
        let isFlat = FileManager.default.fileExists(atPath: paths.generatedRoot.appendingPathComponent("Entities").path)
        return isFlat ? sources : ModuleSplitter.unrender(sources, config: config)
    }

    /// Hand-written Core sources: everything under `Sources/` that the generator doesn't write.
    private static func readHandWrittenSources(paths: OpenAPIGeneratorPaths) throws -> [GeneratedSource] {
        let sourcesRoot = paths.packageRoot.appendingPathComponent("Sources")
        let generatedPrefix = paths.generatedRoot.path.replacingOccurrences(of: sourcesRoot.path + "/", with: "") + "/"
        return try self.readSwiftFiles(in: sourcesRoot).filter { !$0.path.hasPrefix(generatedPrefix) }
    }

    /// Every `.swift` file below `root`, with paths relative to it, sorted.
    private static func readSwiftFiles(in root: URL) throws -> [GeneratedSource] {
        let relativePaths = (try FileManager.default.subpathsOfDirectory(atPath: root.path)).filter { $0.hasSuffix(".swift") }.sorted()
        return try relativePaths.map { relativePath in
            GeneratedSource(path: relativePath, contents: try String(contentsOf: root.appendingPathComponent(relativePath), encoding: .utf8))
        }
    }

    // MARK: - Internals
    
    private static func patchSpecJSON(_ jsonData: Data, writingTo specURL: URL) throws -> SpecPatcher.Result {
        var parser = JSONParser(bytes: [UInt8](jsonData))
        var root = try parser.parse()
        let upstreamResult = try SpecPatcher.patch(&root)
        let outData = try root.toJSONData(prettyPrinted: false)
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


