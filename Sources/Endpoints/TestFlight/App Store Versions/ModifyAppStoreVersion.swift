import Foundation

public extension APIEndpoint where T == AppStoreVersionResponse {

    /// Update the app store version for a specific app.
    ///
    /// # Reference
    /// [Apple Documentation](https://developer.apple.com/documentation/appstoreconnectapi/modify_an_app_store_version)
    static func modify(
        appStoreVersionWithId id: String,
        buildId: String? = nil,
        copyright: String? = nil,
        earliestReleaseDate: Date? = nil,
        releaseType: AppStoreVersionUpdateRequest.Data.Attributes.ReleaseType? = nil,
        usesIdfa: Bool? = nil,
        versionString: String? = nil,
        downloadable: Bool? = nil
    ) -> APIEndpoint {
        let request = AppStoreVersionUpdateRequest(
            id: id,
            buildId: buildId,
            copyright: copyright,
            earliestReleaseDate: earliestReleaseDate,
            releaseType: releaseType,
            usesIdfa: usesIdfa,
            versionString: versionString,
            downloadable: downloadable
        )
        return APIEndpoint(
            path: "appStoreVersions/\(id)",
            method: .patch,
            parameters: nil,
            body: try? JSONEncoder().encode(request)
        )
    }
}
