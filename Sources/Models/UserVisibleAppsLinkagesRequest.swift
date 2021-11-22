//
//  UserVisibleAppsLinkagesRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing the IDs of related resources.
public struct UserVisibleAppsLinkagesRequest: Codable {
    
    public struct Data: Codable {
    
        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// The resource type.Value: apps
        public private(set) var type: String = "apps"
    }
    
    /// The object types and IDs of the related resources.
    public let data: [UserVisibleAppsLinkagesRequest.Data]
    
    /// - Parameters:
    ///   - appIds: Array of opaque resource ID that uniquely identifies the resources.
    init(_ appIds: [String]) {
        data = appIds.map({ Data(id: $0) })
    }
}
