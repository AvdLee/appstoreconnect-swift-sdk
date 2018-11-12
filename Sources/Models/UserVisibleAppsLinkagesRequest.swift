//
//  UserVisibleAppsLinkagesRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing the IDs of related resources.
struct UserVisibleAppsLinkagesRequest: Decodable {

    /// (Required) The object types and IDs of the related resources.
    let data: [UserVisibleAppsLinkagesRequest.Data]

}

extension UserVisibleAppsLinkagesRequest {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: apps
        let type: String
    
    }
}
