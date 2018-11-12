//
//  BuildUpdateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
struct BuildUpdateRequest: Decodable {

    /// (Required) The resource data.
    let data: BuildUpdateRequest.Data
    
    struct Data: Decodable {
    
        /// The resource's attributes.
        let attributes: BuildUpdateRequest.Data.Attributes?
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// Navigational links to related data and included resource types and IDs.
        let relationships: BuildUpdateRequest.Data.Relationships?
    
        /// (Required) The resource type.Value: builds
        let type: String
    }
}

extension BuildUpdateRequest.Data {
    /// Attributes that describe a resource.
    struct Attributes: Decodable {
    
        /// A Boolean value that indicates if the build has expired. An expired build is unavailable for testing.
        let expired: Bool?
    
        /// A Boolean value that indicates whether the build uses non-exempt encryption.
        let usesNonExemptEncryption: Bool?
    }
    
    struct Relationships: Decodable {
    
        /// BuildUpdateRequest.Data.Relationships.AppEncryptionDeclaration
        let appEncryptionDeclaration: BuildUpdateRequest.Data.Relationships.AppEncryptionDeclaration?
    }
}

extension BuildUpdateRequest.Data.Relationships {
    
    struct AppEncryptionDeclaration: Decodable {
    
        /// BuildUpdateRequest.Data.Relationships.AppEncryptionDeclaration.Data
        let data: BuildUpdateRequest.Data.Relationships.AppEncryptionDeclaration.Data?
    }
}

extension BuildUpdateRequest.Data.Relationships.AppEncryptionDeclaration {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: appEncryptionDeclarations
        let type: String
    }
}
