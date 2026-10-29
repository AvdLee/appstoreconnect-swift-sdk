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
    public var alreadyPresent: [String]
    public var missingFiles: [String]

    public init(changedFiles: [String] = [], changes: [String] = [], alreadyPresent: [String] = [], missingFiles: [String] = []) {
        self.changedFiles = changedFiles
        self.changes = changes
        self.alreadyPresent = alreadyPresent
        self.missingFiles = missingFiles
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

        try patchFile(
            rootDir.appendingPathComponent("Entities/AppsBetaTesterUsagesV1MetricResponse.swift"),
            dryRun: dryRun,
            replacements: [
                .init(description: "Decode grouped beta tester dimension as an ID or resource",
                      from: "public var data: String?",
                      to: "public var data: MetricDimensionData?", required: true),
                .init(description: "Initialize grouped beta tester dimension",
                      from: "public init(links: Links? = nil, data: String? = nil)",
                      to: "public init(links: Links? = nil, data: MetricDimensionData? = nil)", required: true),
                .init(description: "Decode grouped beta tester dimension data",
                      from: #"self.data = try values.decodeIfPresent(String.self, forKey: "data")"#,
                      to: #"self.data = try values.decodeIfPresent(MetricDimensionData.self, forKey: "data")"#,
                      required: true),
            ],
            report: &report
        )

        try patchFile(
            rootDir.appendingPathComponent("Entities/BetaTesterUsagesV1MetricResponse.swift"),
            dryRun: dryRun,
            replacements: [
                .init(description: "Decode app metric dimension as an ID or resource",
                      from: "public var data: String?",
                      to: "public var data: MetricDimensionData?", required: true),
                .init(description: "Initialize app metric dimension",
                      from: "public init(links: Links? = nil, data: String? = nil)",
                      to: "public init(links: Links? = nil, data: MetricDimensionData? = nil)", required: true),
                .init(description: "Decode app metric dimension data",
                      from: #"self.data = try values.decodeIfPresent(String.self, forKey: "data")"#,
                      to: #"self.data = try values.decodeIfPresent(MetricDimensionData.self, forKey: "data")"#,
                      required: true),
            ],
            report: &report
        )

        try patchFile(
            rootDir.appendingPathComponent("Entities/AppAssetLibraryPlacementState.swift"),
            dryRun: dryRun,
            replacements: [
                .init(description: "Recognize active asset library placements",
                      from: "public enum AppAssetLibraryPlacementState: String, Codable, CaseIterable {\n\tcase assetProcessing = \"ASSET_PROCESSING\"",
                      to: "public enum AppAssetLibraryPlacementState: String, Codable, CaseIterable {\n\tcase active = \"ACTIVE\"\n\tcase assetProcessing = \"ASSET_PROCESSING\"",
                      required: true),
                .init(description: "Recognize inactive asset library placements",
                      from: "\tcase parentApproved = \"PARENT_APPROVED\"\n}",
                      to: "\tcase parentApproved = \"PARENT_APPROVED\"\n\tcase inactive = \"INACTIVE\"\n}",
                      required: true),
            ],
            report: &report
        )

        try patchFile(
            rootDir.appendingPathComponent("Entities/AppAssetLibraryPlacement.swift"),
            dryRun: dryRun,
            replacements: [
                .init(
                    description: "Select placement relationships by populated image or video data",
                    from: """

			struct Discriminator: Decodable {
				let mediaType: String
			}

			let container = try decoder.singleValueContainer()
			let discriminatorValue = try container.decode(Discriminator.self).mediaType

			switch discriminatorValue {
			case "IMAGE": self = .appAssetLibraryPlacementImageRelationships(try container.decode(AppAssetLibraryPlacementImageRelationships.self))
			case "VIDEO": self = .appAssetLibraryPlacementVideoRelationships(try container.decode(AppAssetLibraryPlacementVideoRelationships.self))

			default:
				throw DecodingError.dataCorruptedError(
					in: container,
					debugDescription: "Discriminator value '\\(discriminatorValue)' does not match any expected values (IMAGE, VIDEO)."
				)
			}
""",
                    to: """
			// The media type is in the placement attributes, not its relationships.
			// Select the relationship variant from populated asset data. Responses can
			// include both keys with a null data value for the unused media type.
			enum AssetKey: String, CodingKey { case image, video }
			struct AssetLink: Decodable {
				struct Resource: Decodable { let id: String }
				let data: Resource?
			}
			let keys = try decoder.container(keyedBy: AssetKey.self)
			if try keys.decodeIfPresent(AssetLink.self, forKey: .video)?.data != nil {
				self = .appAssetLibraryPlacementVideoRelationships(try AppAssetLibraryPlacementVideoRelationships(from: decoder))
			} else {
				self = .appAssetLibraryPlacementImageRelationships(try AppAssetLibraryPlacementImageRelationships(from: decoder))
			}
""",
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
        report.missingFiles.append(url.lastPathComponent)
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
            report.alreadyPresent.append("\(url.lastPathComponent): \(r.description)")
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


