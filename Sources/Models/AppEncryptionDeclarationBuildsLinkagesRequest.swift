//
//  AppEncryptionDeclarationBuildsLinkagesRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a list of related resource IDs.
public struct AppEncryptionDeclarationBuildsLinkagesRequest: Codable {
    
    public struct Data: Codable {
    
        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// The resource type.Value: builds
        public let type: String = "builds"
    }
    
    /// The object types and IDs of the related resources.
    public let data: [AppEncryptionDeclarationBuildsLinkagesRequest.Data]
    
    /// - Parameters:
    ///   - buildIds: Array of opaque resource ID that uniquely identifies the resources.
    init(_ buildIds: [String]) {
        data = buildIds.map({ Data(id: $0) })
    }
}
