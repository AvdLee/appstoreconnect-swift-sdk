//
//  BuildBetaDetailUpdateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource
public struct BuildBetaDetailUpdateRequest: Codable {

    /// - Parameters:
    ///   - id: The opaque resource ID that uniquely identifies the resource.
    ///   - autoNotifyEnabled: A Boolean value that enables you to send test invitations to users automatically when the build is available to external groups.
    init(id: String, autoNotifyEnabled: Bool? = nil) {
        data = .init(attributes: .init(autoNotifyEnabled: autoNotifyEnabled), id: id)
    }
    
    /// (Required) The resource data.
    public let data: BuildBetaDetailUpdateRequest.Data
    
    public struct Data: Codable {
    
        /// The resource's attributes.
        public let attributes: BuildBetaDetailUpdateRequest.Data.Attributes?
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: buildBetaDetails
        public let type: String = "buildBetaDetails"
    }
}

/// MARK: BuildBetaDetailUpdateRequest.Data
extension BuildBetaDetailUpdateRequest.Data {
    /// Attributes that describe a resource.
    public struct Attributes: Codable {
    
        /// A Boolean value that enables you to send test invitations to users automatically when the build is available to external groups.
        public let autoNotifyEnabled: Bool?
    }
}
