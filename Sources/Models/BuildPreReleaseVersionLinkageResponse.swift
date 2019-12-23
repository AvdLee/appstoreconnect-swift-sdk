//
//  BuildPreReleaseVersionLinkageResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing the ID of the related resource.
public struct BuildPreReleaseVersionLinkageResponse: Codable {
    
    public struct Data: Codable {
    
        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// The resource type.Value: preReleaseVersions
        public let type: String = "preReleaseVersions"
    }
    
    /// The object types and IDs of the related resources.
    public let data: BuildPreReleaseVersionLinkageResponse.Data

    /// Navigational links including the self-link and links to the related data.
    public let links: DocumentLinks
}
