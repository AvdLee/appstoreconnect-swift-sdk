//
//  GetBetaAppReviewSubmissionIDOfBuild.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//
    

extension APIEndpoint where T == BuildBetaAppReviewSubmissionLinkageResponse {

    /// Get the beta app review submission resource ID associated with a specific build.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func betaAppReviewSubmissionID(ofBuildWithId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "builds/\(id)/relationships/betaAppReviewSubmission",
            method: .get,
            parameters: nil)
    }
}
