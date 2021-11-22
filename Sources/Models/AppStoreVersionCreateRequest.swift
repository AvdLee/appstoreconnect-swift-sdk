import Foundation

public struct AppStoreVersionCreateRequest: Codable {

    public let data: AppStoreVersionCreateRequest.Data

    public init(
        appStoreVersionForAppId id: String,
        versionString: String,
        platform: AppStoreVersionCreateRequest.Data.Attributes.Platform,
        copyright: String? = nil,
        earliestReleaseDate: Date? = nil,
        releaseType: AppStoreVersionCreateRequest.Data.Attributes.ReleaseType? = nil,
        usesIdfa: Bool? = nil,
        buildId: String? = nil
    ) {
        var build: AppStoreVersionCreateRequest.Data.Relationships.Build?
        if let buildId = buildId {
            build = .init(data: .init(id: buildId))
        }

        data = .init(attributes: .init(copyright: copyright,
                                       earliestReleaseDate: earliestReleaseDate,
                                       platform: platform,
                                       releaseType: releaseType,
                                       usesIdfa: usesIdfa,
                                       versionString: versionString),
                     relationships: .init(app: .init(data: .init(id: id)),
                                          build: build))
    }
}

// MARK: AppStoreVersionCreateRequest
extension AppStoreVersionCreateRequest {

    public struct Data: Codable {

        public let attributes: AppStoreVersionCreateRequest.Data.Attributes

        public let relationships: AppStoreVersionCreateRequest.Data.Relationships

        public private(set) var type: String = "appStoreVersions"
    }
}

// MARK: AppStoreVersionCreateRequest.Data
extension AppStoreVersionCreateRequest.Data {

    public struct Attributes: Codable {

        public let copyright: String?

        public let earliestReleaseDate: Date?

        public let platform: AppStoreVersionCreateRequest.Data.Attributes.Platform

        public let releaseType: AppStoreVersionCreateRequest.Data.Attributes.ReleaseType?

        public let usesIdfa: Bool?

        public let versionString: String
    }

    public struct Relationships: Codable {

        public let app: AppStoreVersionCreateRequest.Data.Relationships.App

        public let build: AppStoreVersionCreateRequest.Data.Relationships.Build?
    }
}

// MARK: AppStoreVersionCreateRequest.Data.Attributes
extension AppStoreVersionCreateRequest.Data.Attributes {

    public enum Platform: String, CaseIterable, Codable {
        case iOS = "IOS"
        case macOS = "MAC_OS"
        case tvOS = "TV_OS"
    }

    public enum ReleaseType: String, CaseIterable, Codable {
        case manual = "MANUAL"
        case afterApproval = "AFTER_APPROVAL"
        case scheduled = "SCHEDULED"
    }
}

// MARK: AppStoreVersionCreateRequest.Data.Relationships
extension AppStoreVersionCreateRequest.Data.Relationships {

    public struct App: Codable {

        public let data: AppStoreVersionCreateRequest.Data.Relationships.App.Data
    }

    public struct Build: Codable {

        public let data: AppStoreVersionCreateRequest.Data.Relationships.Build.Data?
    }
}

// MARK: AppStoreVersionCreateRequest.Data.Relationships.App
extension AppStoreVersionCreateRequest.Data.Relationships.App {

    public struct Data: Codable {

        public let id: String

        public private(set) var type: String = "apps"
    }
}

// MARK: AppStoreVersionCreateRequest.Data.Relationships.Build
extension AppStoreVersionCreateRequest.Data.Relationships.Build {

    public struct Data: Codable {

        public let id: String

        public private(set) var type: String = "builds"
    }
}
