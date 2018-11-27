//
//  GetBetaAppReviewDetailsResourceIDForApp.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint {

    /// Get the beta app review details resource ID associated with a specific app.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func betaAppReviewDetailsResourceIDForApp(withId id: String) -> APIEndpoint<AppBetaAppReviewDetailLinkageResponse> {
        return APIEndpoint<AppBetaAppReviewDetailLinkageResponse>(
            path: "apps/\(id)/relationships/betaAppReviewDetail",
            method: .get,
            parameters: nil)
    }
}
