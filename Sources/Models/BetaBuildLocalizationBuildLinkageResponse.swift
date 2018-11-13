//
//  BetaBuildLocalizationBuildLinkageResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a single resource.
public struct BetaBuildLocalizationBuildLinkageResponse: Decodable {

    /// (Required) The resource data.
    public let data: BetaBuildLocalizationBuildLinkageResponse.Data

    /// (Required) Navigational links that include the self-link.
    public let links: DocumentLinks
    
    public struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: builds
        public let type: String
    }
}
