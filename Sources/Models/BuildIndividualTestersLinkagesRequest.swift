//
//  BuildIndividualTestersLinkagesRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing the IDs of related resources.
public struct BuildIndividualTestersLinkagesRequest: Codable {
    
    public struct Data: Codable {
    
        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// The resource type.Value: betaTesters
        public let type: String = "betaTesters"
    }
    
    /// The types and IDs of related resources.
    public let data: [BuildIndividualTestersLinkagesRequest.Data]
    
    /// - Parameters:
    ///   - betaTesterIds: Array of opaque resource ID that uniquely identifies the resources.
    init(_ betaTesterIds: [String]) {
        data = betaTesterIds.map({ Data(id: $0) })
    }
}
