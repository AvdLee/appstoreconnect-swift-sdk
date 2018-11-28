//
//  BetaGroupCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
public struct BetaGroupCreateRequest: Codable {

    /// (Required) The resource data.
    public let data: BetaGroupCreateRequest.Data
    
    public struct Data: Codable {
    
        /// (Required) The resource's attributes.
        public let attributes: BetaGroupCreateRequest.Data.Attributes
    
        /// (Required) Navigational links to related data and included resource types and IDs.
        public let relationships: BetaGroupCreateRequest.Data.Relationships
    
        /// (Required) The resource type.Value: betaGroups
        public let type: String = " betaGroups"
    }
}

/// MARK: BetaGroupCreateRequest.Data
extension BetaGroupCreateRequest.Data {
    /// Attributes that describe a resource.
    public struct Attributes: Codable {
    
        /// (Required) The name for the beta group.
        public let name: String
    
        /// A Boolean value that indicates whether a public link is enabled. Enabling a link allows you to invite anyone outside of your team to beta test your app. When you share this link, testers will be able to install the beta version of your app on their devices in TestFlight and share the link with others.
        public let publicLinkEnabled: Bool?
    
        /// The maximum number of testers that can join this beta group using the public link. Values must be between 1 and 10,000.
        public let publicLinkLimit: Int?
    
        /// A Boolean value that limits the number of testers who can join the beta group using the public link.
        public let publicLinkLimitEnabled: Bool?
    }
    
    public struct Relationships: Codable {
    
        /// BetaGroupCreateRequest.Data.Relationships.App (Required)
        public let app: BetaGroupCreateRequest.Data.Relationships.App
    
        /// BetaGroupCreateRequest.Data.Relationships.BetaTesters
        public let betaTesters: BetaGroupCreateRequest.Data.Relationships.BetaTesters?
    
        /// BetaGroupCreateRequest.Data.Relationships.Builds
        public let builds: BetaGroupCreateRequest.Data.Relationships.Builds?
    }
}

/// MARK: BetaGroupCreateRequest.Data.Relationships
extension BetaGroupCreateRequest.Data.Relationships {
    
    public struct App: Codable {
    
        /// BetaGroupCreateRequest.Data.Relationships.App.Data (Required)
        public let data: BetaGroupCreateRequest.Data.Relationships.App.Data
    }
    
    public struct BetaTesters: Codable {
    
        /// [BetaGroupCreateRequest.Data.Relationships.BetaTesters.Data]
        public let data: [BetaGroupCreateRequest.Data.Relationships.BetaTesters.Data]?
    }
    
    public struct Builds: Codable {
    
        /// [BetaGroupCreateRequest.Data.Relationships.Builds.Data]
        public let data: [BetaGroupCreateRequest.Data.Relationships.Builds.Data]?
    }
}

/// MARK: BetaGroupCreateRequest.Data.Relationships.App
extension BetaGroupCreateRequest.Data.Relationships.App {
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: apps
        public let type: String = " apps"
    }
}

/// MARK: BetaGroupCreateRequest.Data.Relationships.BetaTesters
extension BetaGroupCreateRequest.Data.Relationships.BetaTesters {
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: betaTesters
        public let type: String = " betaTesters"
    }
}

/// MARK: BetaGroupCreateRequest.Data.Relationships.Builds
extension BetaGroupCreateRequest.Data.Relationships.Builds {
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: builds
        public let type: String = " builds"
    }
}
