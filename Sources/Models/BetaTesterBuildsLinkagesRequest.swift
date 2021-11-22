//
//  BetaTesterBuildsLinkagesRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing the IDs of related resources.
public struct BetaTesterBuildsLinkagesRequest: Codable {
    
    public struct Data: Codable {
    
        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// The resource type.Value: builds
        public private(set) var type: String = "builds"
    }
    
    /// The types and IDs of related resources.
    public let data: [BetaTesterBuildsLinkagesRequest.Data]
    
    /// - Parameters:
    ///   - buidIds: Array of opaque resource ID that uniquely identifies the resources.
    init(_ buildIds: [String]) {
        data = buildIds.map({ Data(id: $0) })
    }

}
