import Foundation

public extension APIEndpoint where T == AppStoreVersionLocalizationResponse {
    static func modify(
        appStoreVersionLocalizationWithId id: String,
        description: String? = nil,
        keywords: String? = nil,
        marketingUrl: URL? = nil,
        promotionalText: String? = nil,
        supportUrl: URL? = nil,
        whatsNew: String? = nil
    ) -> APIEndpoint {
        let request = AppStoreVersionLocalizationUpdateRequest(
            description: description,
            keywords: keywords,
            marketingUrl: marketingUrl,
            promotionalText: promotionalText,
            supportUrl: supportUrl,
            whatsNew: whatsNew
        )
        return APIEndpoint(
            path: "appStoreVersionLocalizations/\(id)",
            method: .patch,
            parameters: nil,
            body: try? JSONEncoder().encode(request)
        )
    }
}
