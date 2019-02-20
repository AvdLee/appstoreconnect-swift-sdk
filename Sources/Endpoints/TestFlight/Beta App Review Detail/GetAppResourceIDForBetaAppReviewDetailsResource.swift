//
//  GetAppResourceIDForBetaAppReviewDetailsResource.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == BetaAppReviewDetailAppLinkageResponse {

    /// Get the app resource ID associated with an app review detail.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func appID(forBetaAppReviewDetailsWithId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "betaAppReviewDetails/\(id)/relationships/app",
            method: .get,
            parameters: nil)
    }
}
