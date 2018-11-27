//
//  AppEncryptionDeclarationBuildsLinkagesRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//
//  swiftlint:disable type_name

import Foundation
    
/// A response containing a list of related resource IDs.
public struct AppEncryptionDeclarationBuildsLinkagesRequest: Codable {

    /// (Required) The object types and IDs of the related resources.
    public let data: [AppEncryptionDeclarationBuildsLinkagesRequest.Data]
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: builds
        public let type: String
    }
}
