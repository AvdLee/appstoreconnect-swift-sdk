//
//  BuildAppEncryptionDeclarationLinkageRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing the ID of the related resource.
struct BuildAppEncryptionDeclarationLinkageRequest: Decodable {

    /// (Required) The types and IDs of related resources.
    let data: BuildAppEncryptionDeclarationLinkageRequest.Data
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: appEncryptionDeclarations
        let type: String
    }
}
