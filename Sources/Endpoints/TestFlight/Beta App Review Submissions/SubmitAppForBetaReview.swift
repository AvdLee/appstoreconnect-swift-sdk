//
//  SubmitAppForBetaReview.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

import Foundation

extension APIEndpoint where Request == BetaAppReviewSubmissionCreateRequest, Response == BetaAppReviewSubmissionResponse {

    /// Submit an app for beta app review to allow external testing.
    ///
    /// - Parameters:
    ///   - buildId: The opaque resource ID that uniquely identifies the resource.
    public static func submitAppForBetaReview(buildWithId id: String) -> APIEndpoint {
        let request = BetaAppReviewSubmissionCreateRequest(buildId: id)
        return APIEndpoint(
            path: "betaAppReviewSubmissions",
            method: .post,
            parameters: nil,
            body: request)
    }
}
