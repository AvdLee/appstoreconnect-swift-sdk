import Foundation

public struct AppStoreVersionLocalizationUpdateRequest: Codable {
    public struct Data: Codable {
        public let attributes: AppStoreVersionLocalizationUpdateRequest.Data.Attributes

        public let type: String = "appStoreVersionLocalizations"
    }

    public let data: AppStoreVersionLocalizationUpdateRequest.Data

    init(description: String? = nil,
         keywords: String? = nil,
         marketingUrl: String? = nil,
         promotionalText: String? = nil,
         supportUrl: String? = nil,
         whatsNew: String? = nil)
    {
        self.data = .init(attributes:
            .init(
                description: description,
                keywords: keywords,
                marketingUrl: marketingUrl,
                promotionalText: promotionalText,
                supportUrl: supportUrl,
                whatsNew: whatsNew
            ))
    }
}

public extension AppStoreVersionLocalizationUpdateRequest.Data {
    struct Attributes: Codable {
        public let description: String?

        public let keywords: String?

        public let marketingUrl: String?

        public let promotionalText: String?

        public let supportUrl: String?

        public let whatsNew: String?
    }
}
