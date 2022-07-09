import Foundation

public struct AppStoreVersionLocalizationUpdateRequest: Codable {
    public struct Data: Codable {
        public let attributes: AppStoreVersionLocalizationUpdateRequest.Data.Attributes

        public let id: String

        public private(set) var type: String = "appStoreVersionLocalizations"
    }

    public let data: AppStoreVersionLocalizationUpdateRequest.Data

    init(
        id: String,
        description: String? = nil,
        keywords: String? = nil,
        marketingUrl: URL? = nil,
        promotionalText: String? = nil,
        supportUrl: URL? = nil,
        whatsNew: String? = nil
    ) {
        self.data = .init(attributes: .init(description: description,
                                            keywords: keywords,
                                            marketingUrl: marketingUrl,
                                            promotionalText: promotionalText,
                                            supportUrl: supportUrl,
                                            whatsNew: whatsNew),
                          id: id)
    }
}

public extension AppStoreVersionLocalizationUpdateRequest.Data {
    struct Attributes: Codable {
        public let description: String?

        public let keywords: String?

        public let marketingUrl: URL?

        public let promotionalText: String?

        public let supportUrl: URL?

        public let whatsNew: String?
    }
}
