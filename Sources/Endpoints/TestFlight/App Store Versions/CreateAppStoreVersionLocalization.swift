import Foundation

public extension APIEndpoint where T == AppStoreVersionLocalizationResponse {
    static func create(
        appStoreVersionLocalizationForVersionWithId versionId: String,
        locale: String,
        description: String? = nil,
        keywords: String? = nil,
        marketingUrl: String? = nil,
        promotionalText: String? = nil,
        supportUrl: String? = nil,
        whatsNew: String? = nil
    ) -> APIEndpoint {
        let request = AppStoreVersionLocalizationCreateRequest(
            appStoreVersionId: versionId,
            locale: locale,
            description: description,
            keywords: keywords,
            marketingUrl: marketingUrl,
            promotionalText: promotionalText,
            supportUrl: supportUrl,
            whatsNew: whatsNew
        )
        return APIEndpoint(
            path: "appStoreVersionLocalizations",
            method: .post,
            parameters: nil,
            body: try? JSONEncoder().encode(request)
        )
    }
}
