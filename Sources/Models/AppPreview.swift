import Foundation

public struct AppPreview: Codable {
    public struct Attributes: Codable {
        public let assetDeliveryState: AppMediaAssetState?
        public let fileName: String?
        public let fileSize: Int?
        public let mimeType: String?
        public let previewFrameTimeCode: String?
        public let previewImage: ImageAsset?
        public let sourceFileChecksum: String?
        public let uploadOperations: [UploadOperation]?
        public let videoUrl: String?
    }

    public struct Relationships: Codable {
        public let appPreviewSet: AppPreview.Relationships.AppPreviewSet?
    }

    public let attributes: AppScreenshot.Attributes?

    public let id: String

    public let relationships: AppScreenshot.Relationships?

    public let type: String = "appPreview"

    public let links: ResourceLinks<AppScreenshotResponse>
}

public extension AppPreview.Relationships {
    struct AppPreviewSet: Codable {
        public let data: AppPreview.Relationships.AppPreviewSet.Data?

        public let links: AppPreview.Relationships.AppPreviewSet.Links?

        public let meta: PagingInformation?
    }
}

public extension AppPreview.Relationships.AppPreviewSet {
    struct Data: Codable {
        public let id: String

        public let type: String = "appPreviewsSets"
    }

    struct Links: Codable {
        /// uri-reference
        public let related: URL?

        /// uri-reference
        public let `self`: URL?
    }
}
