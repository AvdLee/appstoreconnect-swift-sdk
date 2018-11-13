//
//  BetaAppReviewSubmissionBuildLinkageResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing the ID of the related resource.
public struct BetaAppReviewSubmissionBuildLinkageResponse: Decodable {

    /// (Required) The object types and IDs of the related resources.
    public let data: BetaAppReviewSubmissionBuildLinkageResponse.Data

    /// (Required) Navigational links including the self-link and links to the related data.
    public let links: DocumentLinks
    
    public struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: builds
        public let type: String
    }
}
