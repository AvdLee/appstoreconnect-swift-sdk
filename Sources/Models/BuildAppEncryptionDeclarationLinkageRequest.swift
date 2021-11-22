//
//  BuildAppEncryptionDeclarationLinkageRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation

/// A request containing the ID of the related resource.
public struct BuildAppEncryptionDeclarationLinkageRequest: Codable {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: appEncryptionDeclarations
        public private(set) var type: String = "appEncryptionDeclarations"
    }

    /// The types and IDs of related resources.
    public let data: BuildAppEncryptionDeclarationLinkageRequest.Data

    /// - Parameters:
    ///   - appEncryptionDeclarationId: The of opaque resource ID that uniquely identifies the resource.
    init(_ appEncryptionDeclarationId: String) {
        data = Data(id: appEncryptionDeclarationId)
    }
}
