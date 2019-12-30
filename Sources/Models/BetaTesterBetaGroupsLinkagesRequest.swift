//
//  BetaTesterBetaGroupsLinkagesRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing the IDs of related resources.
public struct BetaTesterBetaGroupsLinkagesRequest: Codable {
    
    public struct Data: Codable {
    
        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// The resource type.Value: betaGroups
        public let type: String = "betaGroups"
    }

    /// The types and IDs of related resources.
    public let data: [BetaTesterBetaGroupsLinkagesRequest.Data]
    
    /// - Parameters:
    ///   - betaGroupIds: Array of opaque resource ID that uniquely identifies the resources.
    init(_ betaGroupIds: [String]) {
        data = betaGroupIds.map({ Data(id: $0) })
    }
}
