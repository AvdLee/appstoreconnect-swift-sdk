import Foundation

public enum GeneratedPatchingError: Error, CustomStringConvertible {
    case cannotRead(URL, Error)
    case cannotWrite(URL, Error)
    case expectedSubstringNotFound(file: String, needle: String)

    public var description: String {
        switch self {
        case .cannotRead(let url, let error):
            return "Failed to read \(url.path): \(error)"
        case .cannotWrite(let url, let error):
            return "Failed to write \(url.path): \(error)"
        case .expectedSubstringNotFound(let file, let needle):
            return "Expected substring not found in \(file): \(needle)"
        }
    }
}

public struct GeneratedPatchReport {
    public var changedFiles: [String]
    public var changes: [String]

    public init(changedFiles: [String] = [], changes: [String] = []) {
        self.changedFiles = changedFiles
        self.changes = changes
    }
}

/// Applies post-processing fixes to CreateAPI-generated Swift sources in a structure-aware (file + pattern) way.
public enum GeneratedPatcher {
    public static func patchGeneratedSources(atRoot rootDir: URL, dryRun: Bool = false) throws -> GeneratedPatchReport {
        var report = GeneratedPatchReport()

        try patchFile(
            rootDir.appendingPathComponent("Entities/AgeRatingDeclarationUpdateRequest.swift"),
            dryRun: dryRun,
            replacements: [
                .init(
                    description: "Allow unsetting kidsAgeBand by encoding optional as null",
                    from: #"try values.encodeIfPresent(kidsAgeBand, forKey: "kidsAgeBand")"#,
                    to:   #"try values.encode(kidsAgeBand, forKey: "kidsAgeBand")"#,
                    required: true
                ),
                .init(
                    description: "Allow unsetting developerAgeRatingInfoURL by encoding optional as null",
                    from: #"try values.encodeIfPresent(developerAgeRatingInfoURL, forKey: "developerAgeRatingInfoUrl")"#,
                    to:   #"try values.encode(developerAgeRatingInfoURL, forKey: "developerAgeRatingInfoUrl")"#,
                    required: true
                ),
            ],
            report: &report
        )

        try patchFile(
            rootDir.appendingPathComponent("Entities/NominationUpdateRequest.swift"),
            dryRun: dryRun,
            replacements: [
                .init(
                    description: "Encode publishEndDate as null when nil",
                    from: #"try values.encodeIfPresent(publishEndDate, forKey: "publishEndDate")"#,
                    to:   #"try values.encode(publishEndDate, forKey: "publishEndDate")"#,
                    required: true
                ),
            ],
            report: &report
        )

        try patchFile(
            rootDir.appendingPathComponent("Entities/AppStoreVersionUpdateRequest.swift"),
            dryRun: dryRun,
            replacements: [
                .init(
                    description: "Encode update data as null when nil",
                    from: #"try values.encodeIfPresent(data, forKey: "data")"#,
                    to:   #"try values.encode(data, forKey: "data")"#,
                    required: true
                ),
            ],
            report: &report
        )

        try patchFile(
            rootDir.appendingPathComponent("Entities/CiGitUser.swift"),
            dryRun: dryRun,
            replacements: [
                .init(
                    description: "Decode avatarUrl as String? instead of URL? (upstream sends invalid URLs)",
                    from: "public var avatarURL: URL?",
                    to:   "public var avatarURL: String?",
                    required: true
                ),
                .init(
                    description: "Update init signature avatarURL type to String? (order-independent)",
                    from: "avatarURL: URL? = nil",
                    to:   "avatarURL: String? = nil",
                    required: true
                ),
                .init(
                    description: "Decode avatarUrl as String",
                    from: #"self.avatarURL = try values.decodeIfPresent(URL.self, forKey: "avatarUrl")"#,
                    to:   #"self.avatarURL = try values.decodeIfPresent(String.self, forKey: "avatarUrl")"#,
                    required: true
                ),
            ],
            report: &report
        )

        try patchFile(
            rootDir.appendingPathComponent("Entities/CiBuildRun.swift"),
            dryRun: dryRun,
            replacements: [
                .init(
                    description: "Decode webUrl as String? instead of URL? (upstream sends invalid URLs)",
                    from: "public var webURL: URL?",
                    to:   "public var webURL: String?",
                    required: true
                ),
                .init(
                    description: "Update init signature webURL type to String?",
                    from: "webURL: URL? = nil",
                    to:   "webURL: String? = nil",
                    required: true
                ),
                .init(
                    description: "Decode webUrl as String",
                    from: #"self.webURL = try values.decodeIfPresent(URL.self, forKey: "webUrl")"#,
                    to:   #"self.webURL = try values.decodeIfPresent(String.self, forKey: "webUrl")"#,
                    required: true
                ),
            ],
            report: &report
        )

        return report
    }
}

// MARK: - Internals

private struct Replacement {
    var description: String
    var from: String
    var to: String
    var required: Bool
}

private func patchFile(_ url: URL, dryRun: Bool, replacements: [Replacement], report: inout GeneratedPatchReport) throws {
    let fm = FileManager.default
    var isDir: ObjCBool = false
    guard fm.fileExists(atPath: url.path, isDirectory: &isDir), !isDir.boolValue else {
        return
    }

    let original: String
    do {
        original = try String(contentsOf: url, encoding: .utf8)
    } catch {
        throw GeneratedPatchingError.cannotRead(url, error)
    }

    var updated = original
    var fileChanged = false

    for r in replacements {
        if updated.contains(r.from) {
            updated = updated.replacingOccurrences(of: r.from, with: r.to)
            fileChanged = true
            report.changes.append("\(url.lastPathComponent): \(r.description)")
        } else if updated.contains(r.to) {
            continue
        } else if r.required {
            throw GeneratedPatchingError.expectedSubstringNotFound(file: url.path, needle: r.from)
        }
    }

    if fileChanged {
        report.changedFiles.append(url.path)
        if !dryRun {
            do {
                try updated.write(to: url, atomically: true, encoding: .utf8)
            } catch {
                throw GeneratedPatchingError.cannotWrite(url, error)
            }
        }
    }
}



