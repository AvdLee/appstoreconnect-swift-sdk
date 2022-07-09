import Foundation

public struct AppStoreVersionLocalizationCreateRequest: Codable {
    public struct Data: Codable {
        public let attributes: AppStoreVersionLocalizationCreateRequest.Data.Attributes

        public let relationships: AppStoreVersionLocalizationCreateRequest.Data.Relationships

        public private(set) var type: String = "appStoreVersionLocalizations"
    }

    public let data: AppStoreVersionLocalizationCreateRequest.Data

    init(
        appStoreVersionId: String,
        locale: String,
        description: String? = nil,
        keywords: String? = nil,
        marketingUrl: URL? = nil,
        promotionalText: String? = nil,
        supportUrl: URL? = nil,
        whatsNew: String? = nil
    ) {
        self.data = .init(attributes:
            .init(
                locale: locale,
                description: description,
                keywords: keywords,
                marketingUrl: marketingUrl,
                promotionalText: promotionalText,
                supportUrl: supportUrl,
                whatsNew: whatsNew
            ),
            relationships: .init(appStoreVersion: .init(data: .init(id: appStoreVersionId))))
    }
}

public extension AppStoreVersionLocalizationCreateRequest.Data {
    struct Attributes: Codable {
        public let locale: String

        public let description: String?

        public let keywords: String?

        public let marketingUrl: URL?

        public let promotionalText: String?

        public let supportUrl: URL?

        public let whatsNew: String?
    }

    struct Relationships: Codable {
        public let appStoreVersion: AppStoreVersionLocalizationCreateRequest.Data.Relationships.AppStoreVersion
    }
}

// MARK: BetaAppLocalizationCreateRequest.Data.Relationships

public extension AppStoreVersionLocalizationCreateRequest.Data.Relationships {
    struct AppStoreVersion: Codable {
        public let data: AppStoreVersionLocalizationCreateRequest.Data.Relationships.AppStoreVersion.Data
    }
}

// MARK: BetaAppLocalizationCreateRequest.Data.Relationships.App

public extension AppStoreVersionLocalizationCreateRequest.Data.Relationships.AppStoreVersion {
    struct Data: Codable {
        public let id: String

        public private(set) var type: String = "appStoreVersions"
    }
}
