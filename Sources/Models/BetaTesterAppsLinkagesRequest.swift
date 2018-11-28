//
//  BetaTesterAppsLinkagesRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing the IDs of related resources.
public struct BetaTesterAppsLinkagesRequest: Codable {

    /// - Parameters:
    ///   - appIds: Array of opaque resource ID that uniquely identifies the resources.
    public init(_ appIds: [String]) {
        data = appIds.map({ Data(id: $0) })
    }

    /// (Required) The types and IDs of related resources.
    public let data: [BetaTesterAppsLinkagesRequest.Data]
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: apps
        public let type: String = " apps"
    }
}
