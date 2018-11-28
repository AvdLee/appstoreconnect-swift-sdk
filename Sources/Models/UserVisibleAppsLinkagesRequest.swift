//
//  UserVisibleAppsLinkagesRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing the IDs of related resources.
public struct UserVisibleAppsLinkagesRequest: Codable {

    /// - Parameters:
    ///   - appIds: Array of opaque resource ID that uniquely identifies the resources.
    public init(_ appIds: [String]) {
        data = appIds.map({ Data(id: $0) })
    }

    /// (Required) The object types and IDs of the related resources.
    public let data: [UserVisibleAppsLinkagesRequest.Data]
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: apps
        public let type: String = " apps"
    }
}
