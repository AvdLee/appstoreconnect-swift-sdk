import Foundation

public extension APIEndpoint where T == AppStoreVersionResponse {
    static func create(
        appStoreVersionForAppId id: String,
        versionString: String,
        platform: AppStoreVersionCreateRequest.Data.Attributes.Platform,
        copyright: String? = nil,
        earliestReleaseDate: Date? = nil,
        releaseType: AppStoreVersionCreateRequest.Data.Attributes.ReleaseType? = nil,
        usesIdfa: Bool? = nil,
        buildId: String? = nil
    ) -> APIEndpoint {
        let request = AppStoreVersionCreateRequest(
            appStoreVersionForAppId: id,
            versionString: versionString,
            platform: platform,
            copyright: copyright,
            earliestReleaseDate: earliestReleaseDate,
            releaseType: releaseType,
            usesIdfa: usesIdfa,
            buildId: buildId
        )
        return APIEndpoint(
            path: "appStoreVersions",
            method: .post,
            parameters: nil,
            body: try? JSONEncoder().encode(request)
        )
    }
}
