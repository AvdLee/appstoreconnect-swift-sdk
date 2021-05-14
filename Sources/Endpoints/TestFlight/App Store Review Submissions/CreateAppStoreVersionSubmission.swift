import Foundation

public extension APIEndpoint where T == AppStoreVersionSubmissionResponse {
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
