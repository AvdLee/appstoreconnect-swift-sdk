//
//  BetaAppReviewSubmissionCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
struct BetaAppReviewSubmissionCreateRequest: Decodable {

    /// (Required) The resource data.
    let data: BetaAppReviewSubmissionCreateRequest.Data
    
    struct Data: Decodable {
    
        /// (Required) The types and IDs of the related data to update.
        let relationships: BetaAppReviewSubmissionCreateRequest.Data.Relationships
    
        /// (Required) The resource type.Value: betaAppReviewSubmissions
        let type: String
    }
}

extension BetaAppReviewSubmissionCreateRequest.Data {
    
    struct Relationships: Decodable {
    
        /// BetaAppReviewSubmissionCreateRequest.Data.Relationships.Build (Required)
        let build: BetaAppReviewSubmissionCreateRequest.Data.Relationships.Build
    }
}

extension BetaAppReviewSubmissionCreateRequest.Data.Relationships {
    
    struct Build: Decodable {
    
        /// BetaAppReviewSubmissionCreateRequest.Data.Relationships.Build.Data (Required)
        let data: BetaAppReviewSubmissionCreateRequest.Data.Relationships.Build.Data
    }
}

extension BetaAppReviewSubmissionCreateRequest.Data.Relationships.Build {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: builds
        let type: String
    }
}
