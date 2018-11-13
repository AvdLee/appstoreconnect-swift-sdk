//
//  BetaAppReviewSubmissionCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
public struct BetaAppReviewSubmissionCreateRequest: Decodable {

    /// (Required) The resource data.
    public let data: BetaAppReviewSubmissionCreateRequest.Data
    
    public struct Data: Decodable {
    
        /// (Required) The types and IDs of the related data to update.
        public let relationships: BetaAppReviewSubmissionCreateRequest.Data.Relationships
    
        /// (Required) The resource type.Value: betaAppReviewSubmissions
        public let type: String
    }
}

/// MARK: BetaAppReviewSubmissionCreateRequest.Data
extension BetaAppReviewSubmissionCreateRequest.Data {
    
    public struct Relationships: Decodable {
    
        /// BetaAppReviewSubmissionCreateRequest.Data.Relationships.Build (Required)
        public let build: BetaAppReviewSubmissionCreateRequest.Data.Relationships.Build
    }
}

/// MARK: BetaAppReviewSubmissionCreateRequest.Data.Relationships
extension BetaAppReviewSubmissionCreateRequest.Data.Relationships {
    
    public struct Build: Decodable {
    
        /// BetaAppReviewSubmissionCreateRequest.Data.Relationships.Build.Data (Required)
        public let data: BetaAppReviewSubmissionCreateRequest.Data.Relationships.Build.Data
    }
}

/// MARK: BetaAppReviewSubmissionCreateRequest.Data.Relationships.Build
extension BetaAppReviewSubmissionCreateRequest.Data.Relationships.Build {
    
    public struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: builds
        public let type: String
    }
}
