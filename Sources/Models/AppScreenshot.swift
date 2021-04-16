import Foundation

public struct AppScreenshot: Codable {
    public struct Attributes: Codable {
        public let assetDeliveryState: AppMediaAssetState?
        public let assetToken: String?
        public let assetType: String?
        public let fileName: String?
        public let fileSize: Int?
        public let imageAsset: ImageAsset?
        public let sourceFileChecksum: String?
        public let uploadOperations: [UploadOperation]?
    }

    public struct Relationships: Codable {
        public let appScreenshotSet: AppScreenshot.Relationships.AppScreenshotSet?
    }

    public let attributes: AppScreenshot.Attributes?

    public let id: String

    public let relationships: AppScreenshot.Relationships?

    public let type: String = "appScreenshots"

    public let links: ResourceLinks<AppScreenshotResponse>
}

public extension AppScreenshot.Relationships {
    struct AppScreenshotSet: Codable {
        public let data: AppScreenshot.Relationships.AppScreenshotSet.Data?

        public let links: AppScreenshot.Relationships.AppScreenshotSet.Links?
    }
}

public extension AppScreenshot.Relationships.AppScreenshotSet {
    struct Data: Codable {
        public let id: String

        public let type: String = "appScreenshotSets"
    }

    struct Links: Codable {
        /// uri-reference
        public let related: URL?

        /// uri-reference
        public let `self`: URL?
    }
}
