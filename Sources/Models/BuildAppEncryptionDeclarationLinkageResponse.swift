//
//  BuildAppEncryptionDeclarationLinkageResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing the ID of the related resource.
struct BuildAppEncryptionDeclarationLinkageResponse: Decodable {

    /// (Required) The object types and IDs of the related resources.
    let data: BuildAppEncryptionDeclarationLinkageResponse.Data

    /// (Required) Navigational links including the self-link and links to the related data.
    let links: DocumentLinks
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: appEncryptionDeclarations
        let type: String
    }
}
