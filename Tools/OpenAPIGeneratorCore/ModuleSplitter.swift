import Foundation

/// Maps the spec's tags to the modules the SDK is split into. Lives in `Sources/OpenAPI/modules.json`.
public struct ModuleSplitConfig: Codable, Equatable {
    /// Module that holds types shared by several areas.
    public var core: String
    /// Area module name → spec tags whose endpoints belong to it.
    public var areas: [String: [String]]

    public init(core: String, areas: [String: [String]]) {
        self.core = core
        self.areas = areas
    }

    public static func load(from url: URL) throws -> ModuleSplitConfig {
        try JSONDecoder().decode(ModuleSplitConfig.self, from: Data(contentsOf: url))
    }
}

/// The routing facts the split needs from the OpenAPI spec.
public struct SpecRouting: Equatable {
    /// First path segment after the version (e.g. `betaGroups` for `/v1/betaGroups`) → tag of its operations.
    public var topLevelResourceTags: [String: String]
    /// Operation ID → its first tag.
    public var operationTags: [String: String]

    public init(topLevelResourceTags: [String: String], operationTags: [String: String]) {
        self.topLevelResourceTags = topLevelResourceTags
        self.operationTags = operationTags
    }

    public init(specJSON: Data) throws {
        let root = try JSONSerialization.jsonObject(with: specJSON) as? [String: Any] ?? [:]
        let paths = root["paths"] as? [String: Any] ?? [:]

        var operationTags: [String: String] = [:]
        var resourceTagCounts: [String: [String: Int]] = [:]
        for (path, item) in paths {
            guard let operations = item as? [String: Any] else { continue }
            let segments = SpecRouting.segments(of: path)
            // `/v1/builds` and `/v1/builds/{id}` define what a `builds` resource is; nested paths don't.
            let isTopLevel = segments.count == 1 || (segments.count == 2 && segments[1].hasPrefix("{"))
            for (_, value) in operations {
                guard let operation = value as? [String: Any],
                      let tag = (operation["tags"] as? [String])?.first else { continue }
                if let id = operation["operationId"] as? String {
                    operationTags[id] = tag
                }
                if isTopLevel {
                    resourceTagCounts[segments[0], default: [:]][tag, default: 0] += 1
                }
            }
        }

        self.operationTags = operationTags
        self.topLevelResourceTags = resourceTagCounts.mapValues { counts in
            counts.max { lhs, rhs in lhs.value == rhs.value ? lhs.key > rhs.key : lhs.value < rhs.value }!.key
        }
    }

    var allTags: Set<String> {
        Set(self.topLevelResourceTags.values).union(self.operationTags.values)
    }

    /// Path segments after the version prefix, e.g. `/v1/apps/{id}/builds` → `["apps", "{id}", "builds"]`.
    static func segments(of path: String) -> [String] {
        let parts = path.split(separator: "/").map(String.init)
        guard let first = parts.first, first.first == "v", Int(first.dropFirst()) != nil else { return parts }
        return Array(parts.dropFirst())
    }
}

public struct GeneratedSource: Equatable {
    /// Path relative to the generated root, e.g. `Entities/App.swift`.
    public var path: String
    public var contents: String

    public init(path: String, contents: String) {
        self.path = path
        self.contents = contents
    }
}

public enum ModuleSplitterError: Error, Equatable, CustomStringConvertible {
    case unmappedTags([String])
    case tagMappedMoreThanOnce(tag: String, areas: [String])

    public var description: String {
        switch self {
        case .unmappedTags(let tags):
            return "Spec tags without a module in modules.json: \(tags.joined(separator: ", "))"
        case .tagMappedMoreThanOnce(let tag, let areas):
            return "Spec tag \(tag) is mapped to more than one module: \(areas.joined(separator: ", "))"
        }
    }
}

/// Which module every generated file belongs to.
public struct ModuleSplit: Equatable {
    public var core: String
    /// Generated file path → module name.
    public var moduleByFile: [String: String]
    /// Entities no endpoint reaches; they are placed in Core.
    public var unreachedEntities: [String]
    /// API path (e.g. `/v1/builds`) → generated file that defines it.
    public var fileByAPIPath: [String: String]
    public var lineCounts: [String: Int]

    /// The modules a consumer needs to call the given API paths.
    public func modules(requiredForPaths paths: [String]) -> [String] {
        let modules = paths.compactMap { self.fileByAPIPath[$0].flatMap { self.moduleByFile[$0] } }
        return Set(modules + [self.core]).sorted()
    }

    public func report() -> ModuleSplitReport {
        var files: [String: Int] = [:]
        var lines: [String: Int] = [:]
        for (file, module) in self.moduleByFile {
            files[module, default: 0] += 1
            lines[module, default: 0] += self.lineCounts[file] ?? 0
        }
        let modules = files.keys
            .map { ModuleSplitReport.Module(name: $0, files: files[$0] ?? 0, lines: lines[$0] ?? 0) }
            .sorted { $0.lines == $1.lines ? $0.name < $1.name : $0.lines > $1.lines }
        return ModuleSplitReport(
            core: self.core,
            modules: modules,
            totalLines: modules.map(\.lines).reduce(0, +),
            unreachedEntities: self.unreachedEntities
        )
    }
}

public struct ModuleSplitReport: Codable, Equatable {
    public struct Module: Codable, Equatable {
        public var name: String
        public var files: Int
        public var lines: Int
    }

    public var core: String
    public var modules: [Module]
    public var totalLines: Int
    public var unreachedEntities: [String]

    public var markdown: String {
        var out = "| Module | Files | Lines | Share |\n|---|---:|---:|---:|\n"
        for module in self.modules {
            let share = self.totalLines == 0 ? 0 : Double(module.lines) * 100 / Double(self.totalLines)
            out += "| \(module.name) | \(module.files) | \(module.lines) | \(String(format: "%.1f", share))% |\n"
        }
        out += "| **Total** | \(self.modules.map(\.files).reduce(0, +)) | \(self.totalLines) | 100% |\n"
        if !self.unreachedEntities.isEmpty {
            out += "\nEntities no endpoint reaches (placed in \(self.core)): \(self.unreachedEntities.joined(separator: ", "))\n"
        }
        return out
    }
}

/// Decides which module each generated file belongs to.
///
/// Endpoints go to the area of the resource they return. Entities go to the single area whose endpoints reach them;
/// entities reached from several areas (or none) go to Core. Everything a Core entity references is reached from the
/// same areas, so Core never depends on an area module and reference cycles always land in one module.
public enum ModuleSplitter {
    /// - Parameter coreSources: Hand-written Core files. Every generated type they use stays in Core.
    public static func split(
        sources: [GeneratedSource],
        coreSources: [GeneratedSource] = [],
        routing: SpecRouting,
        config: ModuleSplitConfig
    ) throws -> ModuleSplit {
        let areaByTag = try self.areaByTag(config: config, routing: routing)

        var entityFileByName: [String: String] = [:]
        for source in sources where source.path.hasPrefix("Entities/") {
            entityFileByName[self.topLevelTypeName(in: source)] = source.path
        }

        var references: [String: Set<String>] = [:]
        for source in sources {
            let identifiers = self.identifiers(in: source.contents)
            references[source.path] = Set(identifiers.compactMap { entityFileByName[$0] }).subtracting([source.path])
        }

        var moduleByFile: [String: String] = [:]
        var fileByAPIPath: [String: String] = [:]
        var reachingAreas: [String: Set<String>] = [:]
        for source in sources where source.path.hasPrefix("Paths/") {
            let apiPath = self.apiPath(in: source.contents)
            if let apiPath {
                fileByAPIPath[apiPath] = source.path
            }
            guard let apiPath, let area = self.area(ofEndpoint: apiPath, source: source, routing: routing, areaByTag: areaByTag) else {
                moduleByFile[source.path] = config.core
                continue
            }
            moduleByFile[source.path] = area

            var stack = Array(references[source.path] ?? [])
            var visited: Set<String> = []
            while let file = stack.popLast() {
                guard visited.insert(file).inserted else { continue }
                reachingAreas[file, default: []].insert(area)
                stack.append(contentsOf: references[file] ?? [])
            }
        }

        var unreached: [String] = []
        for (name, file) in entityFileByName {
            let areas = reachingAreas[file] ?? []
            if areas.isEmpty {
                unreached.append(name)
            }
            moduleByFile[file] = areas.count == 1 ? areas.first! : config.core
        }

        // Core can't depend on an area: everything Core code uses, generated or hand-written, moves to Core too.
        var stack = moduleByFile.filter { $0.value == config.core }.flatMap { references[$0.key] ?? [] }
        for source in coreSources {
            stack.append(contentsOf: self.identifiers(in: source.contents).compactMap { entityFileByName[$0] })
        }
        while let file = stack.popLast() {
            guard moduleByFile[file] != config.core else { continue }
            moduleByFile[file] = config.core
            stack.append(contentsOf: references[file] ?? [])
        }

        return ModuleSplit(
            core: config.core,
            moduleByFile: moduleByFile,
            unreachedEntities: unreached.sorted(),
            fileByAPIPath: fileByAPIPath,
            lineCounts: Dictionary(uniqueKeysWithValues: sources.map { ($0.path, self.lineCount(of: $0.contents)) })
        )
    }

    // MARK: - Config

    private static func areaByTag(config: ModuleSplitConfig, routing: SpecRouting) throws -> [String: String] {
        var areasByTag: [String: [String]] = [:]
        for (area, tags) in config.areas {
            for tag in tags {
                areasByTag[tag, default: []].append(area)
            }
        }
        if let (tag, areas) = areasByTag.filter({ $0.value.count > 1 }).min(by: { $0.key < $1.key }) {
            throw ModuleSplitterError.tagMappedMoreThanOnce(tag: tag, areas: areas.sorted())
        }
        let unmapped = routing.allTags.filter { areasByTag[$0] == nil }
        if !unmapped.isEmpty {
            throw ModuleSplitterError.unmappedTags(unmapped.sorted())
        }
        return areasByTag.mapValues { $0[0] }
    }

    // MARK: - Endpoints

    private static func area(ofEndpoint apiPath: String, source: GeneratedSource, routing: SpecRouting, areaByTag: [String: String]) -> String? {
        let resources = SpecRouting.segments(of: apiPath).filter { !$0.hasPrefix("{") && $0 != "relationships" }
        guard let last = resources.last else { return nil }

        // Placed by the resource returned: `/v1/apps/{id}/betaGroups` belongs where `/v1/betaGroups` does.
        if let tag = routing.topLevelResourceTags[last] {
            return areaByTag[tag]
        }
        if let id = self.firstOperationID(in: source.contents), let tag = routing.operationTags[id] {
            return areaByTag[tag]
        }
        return routing.topLevelResourceTags[resources[0]].flatMap { areaByTag[$0] }
    }

    private static func apiPath(in contents: String) -> String? {
        self.firstMatch(of: #"/// Path: `([^`]+)`"#, in: contents)
    }

    private static func firstOperationID(in contents: String) -> String? {
        self.firstMatch(of: #"id: "([^"]+)""#, in: contents)
    }

    // MARK: - Swift source scanning

    private static func topLevelTypeName(in source: GeneratedSource) -> String {
        if let name = self.firstMatch(of: #"(?m)^public (?:final )?(?:struct|enum|class|typealias) (\w+)"#, in: source.contents) {
            return name
        }
        return URL(fileURLWithPath: source.path).deletingPathExtension().lastPathComponent
    }

    /// Capitalized identifiers outside comments and string literals.
    private static func identifiers(in contents: String) -> Set<String> {
        let code = contents
            .replacingOccurrences(of: #""(?:[^"\\\n]|\\.)*""#, with: "\"\"", options: .regularExpression)
            .replacingOccurrences(of: #"//[^\n]*"#, with: "", options: .regularExpression)
        let regex = try! NSRegularExpression(pattern: #"\b[A-Z][A-Za-z0-9_]*\b"#)
        let range = NSRange(code.startIndex..., in: code)
        return Set(regex.matches(in: code, range: range).compactMap { Range($0.range, in: code).map { String(code[$0]) } })
    }

    private static func firstMatch(of pattern: String, in contents: String) -> String? {
        let regex = try! NSRegularExpression(pattern: pattern)
        guard let match = regex.firstMatch(in: contents, range: NSRange(contents.startIndex..., in: contents)),
              let range = Range(match.range(at: 1), in: contents) else { return nil }
        return String(contents[range])
    }

    private static func lineCount(of contents: String) -> Int {
        guard !contents.isEmpty else { return 0 }
        let newlines = contents.reduce(0) { $1 == "\n" ? $0 + 1 : $0 }
        return contents.hasSuffix("\n") ? newlines : newlines + 1
    }
}

// MARK: - Rendering

extension ModuleSplitConfig {
    /// Swift module name for a module in the config, e.g. `TestFlight` → `AppStoreConnectTestFlight`.
    public func moduleName(_ module: String) -> String {
        "AppStoreConnect" + module
    }

    /// Core first, then the areas alphabetically.
    public var allModules: [String] {
        [self.core] + self.areas.keys.sorted()
    }
}

extension ModuleSplitter {
    static let namespaceFolder = "Namespaces"
    static let umbrellaFolder = "Umbrella"

    /// Turns the flat generated tree into one folder per module.
    ///
    /// - Module qualifiers (`AppStoreConnect_Swift_SDK.X`) are removed so the files compile both as one module and as
    ///   separate modules.
    /// - Area files import Core behind `#if canImport`, which is false when everything is one module.
    /// - A path node extended from another module is split: its declaration (a namespace shell) moves to Core and its
    ///   operations stay in its area as an extension.
    public static func render(sources: [GeneratedSource], split: ModuleSplit, config: ModuleSplitConfig) throws -> [GeneratedSource] {
        let nodes = sources.compactMap(PathNode.init(source:))
        let shelled = self.nodesNeedingCoreShell(nodes, split: split)
        var output: [GeneratedSource] = []

        for source in sources {
            let module = split.moduleByFile[source.path] ?? split.core
            let folder = (source.path as NSString).deletingLastPathComponent
            let name = (source.path as NSString).lastPathComponent
            var contents = self.stripModuleQualifiers(source.contents)

            if let node = nodes.first(where: { $0.file == source.path }), shelled.contains(node.fullName), module != split.core {
                let base = (name as NSString).deletingPathExtension
                output.append(GeneratedSource(path: "\(split.core)/\(self.namespaceFolder)/\(base)+Namespace.swift", contents: node.shell))
                guard let operations = node.operations else { continue }
                contents = self.stripModuleQualifiers(operations)
            }

            if module == split.core {
                if folder == "Extensions" {
                    contents = self.exposeInternalHelpers(contents)
                }
            } else {
                contents = self.insertCoreImport(into: contents, coreModule: config.moduleName(split.core))
            }
            output.append(GeneratedSource(path: "\(module)/\(folder)/\(name)", contents: contents))
        }

        output.append(GeneratedSource(path: "\(self.umbrellaFolder)/Exports.swift", contents: self.umbrella(config: config)))
        return output.sorted { $0.path < $1.path }
    }

    /// The inverse of `render` for analysis: module folders back to `Entities/`, `Paths/`, `Extensions/`.
    /// Namespace shells and the umbrella are dropped; they hold no types or operations of their own.
    public static func unrender(_ rendered: [GeneratedSource], config: ModuleSplitConfig) -> [GeneratedSource] {
        rendered.compactMap { source in
            let components = source.path.split(separator: "/").map(String.init)
            guard components.count == 3, components[0] != self.umbrellaFolder, components[1] != self.namespaceFolder else { return nil }
            return GeneratedSource(path: "\(components[1])/\(components[2])", contents: source.contents)
        }
    }

    /// Nodes whose declaration must be visible in Core: those extended from a module other than their own, and,
    /// transitively, the parents of anything declared in Core.
    private static func nodesNeedingCoreShell(_ nodes: [PathNode], split: ModuleSplit) -> Set<String> {
        let nodeByName = Dictionary(nodes.map { ($0.fullName, $0) }, uniquingKeysWith: { first, _ in first })
        func module(_ node: PathNode) -> String { split.moduleByFile[node.file] ?? split.core }

        var shelled: Set<String> = []
        var pending: [(parent: String, requiredIn: String)] = nodes.map { ($0.parent, module($0)) }
        while let (parentName, requiredIn) = pending.popLast() {
            guard let parent = nodeByName[parentName] else { continue }
            let declaredIn = module(parent)
            guard declaredIn != requiredIn, declaredIn != split.core, shelled.insert(parentName).inserted else { continue }
            // The shell lives in Core, so its own parent must be visible in Core.
            pending.append((parent.parent, split.core))
        }
        return shelled
    }

    private static func stripModuleQualifiers(_ contents: String) -> String {
        contents.replacingOccurrences(of: "AppStoreConnect_Swift_SDK.", with: "")
    }

    private static func insertCoreImport(into contents: String, coreModule: String) -> String {
        let block = "#if canImport(\(coreModule))\n@_spi(Internal) import \(coreModule)\n#endif\n"
        var lines = contents.components(separatedBy: "\n")
        let lastImport = lines.lastIndex(where: { $0.hasPrefix("import ") })
        lines.insert(block.trimmingCharacters(in: .newlines), at: lastImport.map { $0 + 1 } ?? 0)
        return lines.joined(separator: "\n")
    }

    /// Internal helpers in Core's generated extensions (`StringCodingKey`) become SPI so area modules can use them
    /// without them becoming public API.
    private static func exposeInternalHelpers(_ contents: String) -> String {
        var lines = contents.components(separatedBy: "\n")
        var insideInternalType = false
        for index in lines.indices {
            let line = lines[index]
            if let match = line.range(of: #"^(struct|enum|final class|class) "#, options: .regularExpression) {
                lines[index] = "@_spi(Internal) public " + line[match.lowerBound...]
                insideInternalType = true
            } else if insideInternalType, line == "}" {
                insideInternalType = false
            } else if insideInternalType, line.range(of: #"^\t(var|init|func|static|let) "#, options: .regularExpression) != nil
                        || line.range(of: #"^\tinit[?(]"#, options: .regularExpression) != nil {
                lines[index] = "\tpublic " + line.dropFirst()
            }
        }
        return lines.joined(separator: "\n")
    }

    private static func umbrella(config: ModuleSplitConfig) -> String {
        var out = "// Generated by OpenAPIGenerator: re-exports every module, so `import AppStoreConnect_Swift_SDK` keeps working.\n"
        for module in config.allModules.map(config.moduleName) {
            out += "\n#if canImport(\(module))\n@_exported import \(module)\n#endif\n"
        }
        return out
    }
}

/// A generated path file: `extension Parent { accessor; public struct Node { path; operations } }`.
private struct PathNode {
    let file: String
    let parent: String
    let name: String
    private let header: [String]
    private let accessor: [String]
    private let pathComment: String
    private let body: [String]

    var fullName: String { "\(self.parent).\(self.name)" }

    init?(source: GeneratedSource) {
        guard source.path.hasPrefix("Paths/") else { return nil }
        let lines = source.contents.components(separatedBy: "\n")
        guard let extensionIndex = lines.firstIndex(where: { $0.hasPrefix("extension ") && $0.hasSuffix(" {") }),
              let structIndex = lines.firstIndex(where: { $0.range(of: #"^\tpublic struct \w+: Sendable \{$"#, options: .regularExpression) != nil }),
              structIndex + 2 < lines.count,
              lines[structIndex + 1].hasPrefix("\t\t/// Path: `"),
              lines[structIndex + 2] == "\t\tpublic let path: String",
              let closeIndex = lines[structIndex...].firstIndex(of: "\t}") else { return nil }

        let extensionLine = lines[extensionIndex]
        self.file = source.path
        self.parent = String(extensionLine.dropFirst("extension ".count).dropLast(" {".count))
        self.name = lines[structIndex]
            .replacingOccurrences(of: "\tpublic struct ", with: "")
            .replacingOccurrences(of: ": Sendable {", with: "")
        self.header = Array(lines[..<extensionIndex])
        self.accessor = Array(lines[(extensionIndex + 1)..<structIndex])
        self.pathComment = lines[structIndex + 1]
        self.body = Array(lines[(structIndex + 3)..<closeIndex].drop(while: { $0.isEmpty }))
    }

    /// Declaration only: the accessor plus the struct with its `path`.
    var shell: String {
        var lines = self.header + ["extension \(self.parent) {"] + self.accessor
        lines += ["\tpublic struct \(self.name): Sendable {", self.pathComment, "\t\tpublic let path: String", "\t}", "}", ""]
        return lines.joined(separator: "\n")
    }

    /// Everything else in the struct, as an extension of the node. `nil` when the node has no operations.
    var operations: String? {
        guard !self.body.isEmpty else { return nil }
        let dedented = self.body.map { $0.hasPrefix("\t") ? String($0.dropFirst()) : $0 }
        let lines = self.header + ["extension \(self.fullName) {", String(self.pathComment.dropFirst())] + dedented + ["}", ""]
        return lines.joined(separator: "\n")
    }
}
