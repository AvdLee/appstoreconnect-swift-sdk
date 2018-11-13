//
//  AppEncryptionDeclarationBuildsLinkagesRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a list of related resource IDs.
struct AppEncryptionDeclarationBuildsLinkagesRequest: Decodable {

    /// (Required) The object types and IDs of the related resources.
    let data: [AppEncryptionDeclarationBuildsLinkagesRequest.Data]
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: builds
        let type: String
    }
}
