//
//  BuildBetaAppReviewSubmissionLinkageResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing the ID of the related resource.
struct BuildBetaAppReviewSubmissionLinkageResponse: Decodable {

    /// (Required) The object types and IDs of the related resources.
    let data: BuildBetaAppReviewSubmissionLinkageResponse.Data

    /// (Required) Navigational links including the self-link and links to the related data.
    let links: DocumentLinks

}

extension BuildBetaAppReviewSubmissionLinkageResponse {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: betaAppReviewSubmissions
        let type: String
    
    }
}
