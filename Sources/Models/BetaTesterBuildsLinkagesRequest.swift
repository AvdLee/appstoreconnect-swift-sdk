//
//  BetaTesterBuildsLinkagesRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing the IDs of related resources.
struct BetaTesterBuildsLinkagesRequest: Decodable {

    /// (Required) The types and IDs of related resources.
    let data: [BetaTesterBuildsLinkagesRequest.Data]

}

extension BetaTesterBuildsLinkagesRequest {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: builds
        let type: String
    
    }
}
