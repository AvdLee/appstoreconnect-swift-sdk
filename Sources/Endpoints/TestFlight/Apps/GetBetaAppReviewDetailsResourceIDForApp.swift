//
//  GetBetaAppReviewDetailsResourceIDForApp.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//

extension APIEndpoint where Request == EmptyBody, Response == AppBetaAppReviewDetailLinkageResponse {

    /// Get the beta app review details resource ID associated with a specific app.
    ///
    /// - Parameters:
    ///   - id: An opaque resource ID that uniquely identifies the resource.
    public static func betaAppReviewDetailsID(forAppWithId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "apps/\(id)/relationships/betaAppReviewDetail",
            method: .get,
            parameters: nil)
    }
}
