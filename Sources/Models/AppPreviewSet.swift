import Foundation

public struct AppPreviewSet: Codable {
    public struct Attributes: Codable {
        public let previewType: String?
    }

    public struct Relationships: Codable {
        public let appPreviews: AppPreviewSet.Relationships.AppPreviews?

        public let appStoreVersionLocalization: AppPreviewSet.Relationships.AppStoreVersionLocalization?
    }

    public let attributes: AppScreenshot.Attributes?

    public let id: String

    public let relationships: AppScreenshot.Relationships?

    public let type: String = "appPreviewSets"

    public let links: ResourceLinks<AppScreenshotResponse>
}

public extension AppPreviewSet.Relationships {
    struct AppPreviews: Codable {
        public let data: AppPreviewSet.Relationships.AppPreviews.Data?

        public let links: AppPreviewSet.Relationships.AppPreviews.Links?

        public let meta: PagingInformation?
    }

    struct AppStoreVersionLocalization: Codable {
        public let data: AppPreviewSet.Relationships.AppStoreVersionLocalization.Data?

        public let links: AppPreviewSet.Relationships.AppStoreVersionLocalization.Links?
    }
}

public extension AppPreviewSet.Relationships.AppPreviews {
    struct Data: Codable {
        public let id: String

        public let type: String = "appPreviews"
    }

    struct Links: Codable {
        /// uri-reference
        public let related: URL?

        /// uri-reference
        public let `self`: URL?
    }
}

public extension AppPreviewSet.Relationships.AppStoreVersionLocalization {
    struct Data: Codable {
        public let id: String

        public let type: String = "appStoreVersionLocalizations"
    }

    struct Links: Codable {
        /// uri-reference
        public let related: URL?

        /// uri-reference
        public let `self`: URL?
    }
}
