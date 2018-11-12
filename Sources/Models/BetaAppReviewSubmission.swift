//
//  BetaAppReviewSubmission.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
struct BetaAppReviewSubmission: Decodable {

    /// The resource's attributes.
    let attributes: BetaAppReviewSubmission.Attributes?

    /// (Required) The opaque resource ID that uniquely identifies the resource.
    let `id`: String

    /// (Required) Navigational links that include the self-link.
    let links: ResourceLinks

    /// Navigational links to related data and included resource types and IDs.
    let relationships: BetaAppReviewSubmission.Relationships?

    /// (Required) The resource type.Value: betaAppReviewSubmissions
    let type: String

}

extension BetaAppReviewSubmission {
    /// Attributes that describe a resource.
    struct Attributes: Decodable {
    
        /// A state that indicates the current status of the beta app review submission.
        let betaReviewState: BetaReviewState?
    
    }
}

extension BetaAppReviewSubmission {
    
    struct Relationships: Decodable {
    
        /// BetaAppReviewSubmission.Relationships.Build
        let build: BetaAppReviewSubmission.Relationships.Build?
    
    }
}

extension BetaAppReviewSubmission.Relationships {
    
    struct Build: Decodable {
    
        /// BetaAppReviewSubmission.Relationships.Build.Data
        let data: BetaAppReviewSubmission.Relationships.Build.Data?
    
        /// BetaAppReviewSubmission.Relationships.Build.Links
        let links: BetaAppReviewSubmission.Relationships.Build.Links?
    
    }
}

extension BetaAppReviewSubmission.Relationships.Build {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: builds
        let type: String
    
    }
}

extension BetaAppReviewSubmission.Relationships.Build {
    
    struct Links: Decodable {
    
        /// uri-reference
        let related: URL?
    
        /// uri-reference
        let `self`: URL?
    
    }
}
