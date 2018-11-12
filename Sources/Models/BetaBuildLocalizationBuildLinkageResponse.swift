//
//  BetaBuildLocalizationBuildLinkageResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a single resource.
struct BetaBuildLocalizationBuildLinkageResponse: Decodable {

    /// (Required) The resource data.
    let data: BetaBuildLocalizationBuildLinkageResponse.Data

    /// (Required) Navigational links that include the self-link.
    let links: DocumentLinks

}

extension BetaBuildLocalizationBuildLinkageResponse {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: builds
        let type: String
    
    }
}
