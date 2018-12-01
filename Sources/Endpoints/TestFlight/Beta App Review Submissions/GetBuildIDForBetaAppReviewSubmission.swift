//
//  GetBuildIDForBetaAppReviewSubmission.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//
    
import Alamofire

extension APIEndpoint where T == BetaAppReviewSubmissionBuildLinkageResponse {

    /// Get the build resource ID associated with a specific beta app review submission.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func buildID(forBetaAppReviewSubmissionWithId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "betaAppReviewSubmissions/\(id)/relationships/build",
            method: .get,
            parameters: nil)
    }
}
