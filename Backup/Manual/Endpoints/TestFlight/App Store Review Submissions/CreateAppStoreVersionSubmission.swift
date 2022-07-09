import Foundation

public extension APIEndpoint where T == AppStoreVersionSubmissionResponse {

    /// Submit an App Store version to App Review.
    ///
    /// # Reference
    /// [Apple Documentation](https://developer.apple.com/documentation/appstoreconnectapi/create_an_app_store_version_submission)
    static func create(
        appStoreVersionSubmissionForVersionWithId versionId: String
    ) -> APIEndpoint {
        let request = AppStoreVersionSubmissionCreateRequest(
            appStoreVersionId: versionId
        )
        return APIEndpoint(
            path: "appStoreVersionSubmissions",
            method: .post,
            parameters: nil,
            body: try? JSONEncoder().encode(request)
        )
    }
}
