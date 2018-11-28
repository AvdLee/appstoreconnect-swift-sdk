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

    /// - Parameters:
    ///   - buildIds: Array of opaque resource ID that uniquely identifies the resources.
    public init(_ buildIds: [String]) {
        data = buildIds.map({ Data(id: $0) })
    }
    
    /// (Required) The object types and IDs of the related resources.
    public let data: [AppEncryptionDeclarationBuildsLinkagesRequest.Data]
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: builds
        public let type: String = " builds"
    }
}
