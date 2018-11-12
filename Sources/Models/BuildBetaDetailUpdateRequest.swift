//
//  BuildBetaDetailUpdateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource
struct BuildBetaDetailUpdateRequest: Decodable {

    /// (Required) The resource data.
    let data: BuildBetaDetailUpdateRequest.Data
    
    struct Data: Decodable {
    
        /// The resource's attributes.
        let attributes: BuildBetaDetailUpdateRequest.Data.Attributes?
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: buildBetaDetails
        let type: String
    }
}

/// MARK: BuildBetaDetailUpdateRequest.Data
extension BuildBetaDetailUpdateRequest.Data {
    /// Attributes that describe a resource.
    struct Attributes: Decodable {
    
        /// A Boolean value that enables you to send test invitations to users automatically when the build is available to external groups.
        let autoNotifyEnabled: Bool?
    }
}
