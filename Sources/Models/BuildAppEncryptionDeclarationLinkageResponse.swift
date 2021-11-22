//
//  BuildAppEncryptionDeclarationLinkageResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation

/// A response containing the ID of the related resource.
public struct BuildAppEncryptionDeclarationLinkageResponse: Codable {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: appEncryptionDeclarations
        public private(set) var type: String = "appEncryptionDeclarations"
    }

    /// The object types and IDs of the related resources.
    public let data: BuildAppEncryptionDeclarationLinkageResponse.Data

    /// Navigational links including the self-link and links to the related data.
    public let links: DocumentLinks

}
