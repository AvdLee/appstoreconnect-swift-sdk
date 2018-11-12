//
//  BetaGroupCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
struct BetaGroupCreateRequest: Decodable {

    /// (Required) The resource data.
    let data: BetaGroupCreateRequest.Data
    
    struct Data: Decodable {
    
        /// (Required) The resource's attributes.
        let attributes: BetaGroupCreateRequest.Data.Attributes
    
        /// (Required) Navigational links to related data and included resource types and IDs.
        let relationships: BetaGroupCreateRequest.Data.Relationships
    
        /// (Required) The resource type.Value: betaGroups
        let type: String
    }
}

/// MARK: BetaGroupCreateRequest.Data
extension BetaGroupCreateRequest.Data {
    /// Attributes that describe a resource.
    struct Attributes: Decodable {
    
        /// (Required) The name for the beta group.
        let name: String
    
        /// A Boolean value that indicates whether a public link is enabled. Enabling a link allows you to invite anyone outside of your team to beta test your app. When you share this link, testers will be able to install the beta version of your app on their devices in TestFlight and share the link with others.
        let publicLinkEnabled: Bool?
    
        /// The maximum number of testers that can join this beta group using the public link. Values must be between 1 and 10,000.
        let publicLinkLimit: Int?
    
        /// A Boolean value that limits the number of testers who can join the beta group using the public link.
        let publicLinkLimitEnabled: Bool?
    }
    
    struct Relationships: Decodable {
    
        /// BetaGroupCreateRequest.Data.Relationships.App (Required)
        let app: BetaGroupCreateRequest.Data.Relationships.App
    
        /// BetaGroupCreateRequest.Data.Relationships.BetaTesters
        let betaTesters: BetaGroupCreateRequest.Data.Relationships.BetaTesters?
    
        /// BetaGroupCreateRequest.Data.Relationships.Builds
        let builds: BetaGroupCreateRequest.Data.Relationships.Builds?
    }
}

/// MARK: BetaGroupCreateRequest.Data.Relationships
extension BetaGroupCreateRequest.Data.Relationships {
    
    struct App: Decodable {
    
        /// BetaGroupCreateRequest.Data.Relationships.App.Data (Required)
        let data: BetaGroupCreateRequest.Data.Relationships.App.Data
    }
    
    struct BetaTesters: Decodable {
    
        /// [BetaGroupCreateRequest.Data.Relationships.BetaTesters.Data]
        let data: [BetaGroupCreateRequest.Data.Relationships.BetaTesters.Data]?
    }
    
    struct Builds: Decodable {
    
        /// [BetaGroupCreateRequest.Data.Relationships.Builds.Data]
        let data: [BetaGroupCreateRequest.Data.Relationships.Builds.Data]?
    }
}

/// MARK: BetaGroupCreateRequest.Data.Relationships.App
extension BetaGroupCreateRequest.Data.Relationships.App {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: apps
        let type: String
    }
}

/// MARK: BetaGroupCreateRequest.Data.Relationships.BetaTesters
extension BetaGroupCreateRequest.Data.Relationships.BetaTesters {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: betaTesters
        let type: String
    }
}

/// MARK: BetaGroupCreateRequest.Data.Relationships.Builds
extension BetaGroupCreateRequest.Data.Relationships.Builds {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: builds
        let type: String
    }
}
