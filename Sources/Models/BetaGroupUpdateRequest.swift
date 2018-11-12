//
//  BetaGroupUpdateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
struct BetaGroupUpdateRequest: Decodable {

    /// (Required) The resource data.
    let data: BetaGroupUpdateRequest.Data
    
    struct Data: Decodable {
    
        /// The resource's attributes.
        let attributes: BetaGroupUpdateRequest.Data.Attributes?
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: betaGroups
        let type: String
    }
}

extension BetaGroupUpdateRequest.Data {
    /// Attributes that describe a resource.
    struct Attributes: Decodable {
    
        /// The name for the beta group.
        let name: String?
    
        /// A Boolean value that indicates whether a public link is enabled. Enabling a link allows you to invite anyone outside of your team to beta test your app. When you share this link, testers will be able to install the beta version of your app on their devices in TestFlight and share the link with others.
        let publicLinkEnabled: Bool?
    
        /// The maximum number of testers that can join this beta group using the public link. Values must be between 1 and 10,000.
        let publicLinkLimit: Int?
    
        /// A Boolean value that limits the number of testers who can join the beta group using the public link.
        let publicLinkLimitEnabled: Bool?
    }
}
