import Foundation

public struct AppScreenshotSet: Codable {
    public struct Attributes: Codable {
        public let screenshotDisplayType: String?
    }

    public struct Relationships: Codable {
        public let appScreenshots: AppScreenshotSet.Relationships.AppScreenshots?
        public let appStoreVersionLocalization: AppScreenshotSet.Relationships.AppStoreVersionLocalization?
    }

    public let attributes: AppScreenshotSet.Attributes?

    public let id: String

    public let relationships: AppScreenshotSet.Relationships?

    public private(set) var type: String = "appScreenshotSets"

    public let links: ResourceLinks<AppScreenshotSetResponse>
}

public extension AppScreenshotSet.Relationships {
    struct AppScreenshots: Codable {
        public let data: [AppScreenshotSet.Relationships.AppScreenshots.Data]?

        public let links: AppScreenshotSet.Relationships.AppScreenshots.Links?
    }

    struct AppStoreVersionLocalization: Codable {
        public let data: AppScreenshotSet.Relationships.AppStoreVersionLocalization.Data?

        public let links: AppScreenshotSet.Relationships.AppStoreVersionLocalization.Links?
    }
}

public extension AppScreenshotSet.Relationships.AppScreenshots {
    struct Data: Codable {
        public let id: String

        public private(set) var type: String = "appScreenshotSets"
    }

    struct Links: Codable {
        public let related: URL?

        public let `self`: URL?
    }
}

public extension AppScreenshotSet.Relationships.AppStoreVersionLocalization {
    struct Data: Codable {
        public let id: String

        public private(set) var type: String = "appScreenshotSets"
    }

    struct Links: Codable {
        public let related: URL?

        public let `self`: URL?
    }
}
