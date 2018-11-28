//
//  BuildAppEncryptionDeclarationLinkageRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//
//  swiftlint:disable type_name

import Foundation
    
/// A request containing the ID of the related resource.
public struct BuildAppEncryptionDeclarationLinkageRequest: Codable {

    /// (Required) The types and IDs of related resources.
    public let data: BuildAppEncryptionDeclarationLinkageRequest.Data
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: appEncryptionDeclarations
        public let type: String = " appEncryptionDeclarations"
    }
}
