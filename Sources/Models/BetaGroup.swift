//
//  BetaGroup.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
public struct BetaGroup: Codable {

    /// The resource's attributes.
    public let attributes: BetaGroup.Attributes?

    /// The opaque resource ID that uniquely identifies the resource.
    public let `id`: String

    /// Navigational links to related data and included resource types and IDs.
    public let relationships: BetaGroup.Relationships?

    /// The resource type.Value: betaGroups
    public let type: String = "betaGroups"

    /// Navigational links that include the self-link.
    public let links: ResourceLinks<BetaGroupResponse>

    /// Attributes that describe a resource.
    public struct Attributes: Codable {
    
        /// A Boolean value that indicates whether the group is internal. Only existing users of App Store Connect may be added for internal beta testing.
        public let isInternalGroup: Bool?
    
        /// The name for the beta group.
        public let name: String?
    
        /// The URL of the public link provided to your app's beta testers.
        public let publicLink: String?
    
        /// A Boolean value that indicates whether a public link is enabled. Enabling a link allows you to invite anyone outside of your team to beta test your app. When you share this link, testers will be able to install the beta version of your app on their devices in TestFlight and share the link with others.
        public let publicLinkEnabled: Bool?
    
        /// The ID as part of the URL of the public link.
        public let publicLinkId: String?
    
        /// The maximum number of testers that can join this beta group using the public link. Values must be between 1 and 10,000.
        public let publicLinkLimit: Int?
    
        /// A Boolean value that limits the number of testers who can join the beta group using the public link.
        public let publicLinkLimitEnabled: Bool?
    
        /// The creation date of the beta group.
        public let createdDate: Date?
    }

    public struct Relationships: Codable {
    
        /// BetaGroup.Relationships.App
        public let app: BetaGroup.Relationships.App?
    
        /// BetaGroup.Relationships.BetaTesters
        public let betaTesters: BetaGroup.Relationships.BetaTesters?
    
        /// BetaGroup.Relationships.Builds
        public let builds: BetaGroup.Relationships.Builds?
    }
}

/// MARK: BetaGroup.Relationships
extension BetaGroup.Relationships {
    
    public struct App: Codable {
    
        /// BetaGroup.Relationships.App.Data
        public let data: BetaGroup.Relationships.App.Data?
    
        /// BetaGroup.Relationships.App.Links
        public let links: BetaGroup.Relationships.App.Links?
    }
    
    public struct BetaTesters: Codable {
    
        /// [BetaGroup.Relationships.BetaTesters.Data]
        public let data: [BetaGroup.Relationships.BetaTesters.Data]?
    
        /// BetaGroup.Relationships.BetaTesters.Links
        public let links: BetaGroup.Relationships.BetaTesters.Links?
    
        /// PagingInformation
        public let meta: PagingInformation?
    }
    
    public struct Builds: Codable {
    
        /// [BetaGroup.Relationships.Builds.Data]
        public let data: [BetaGroup.Relationships.Builds.Data]?
    
        /// BetaGroup.Relationships.Builds.Links
        public let links: BetaGroup.Relationships.Builds.Links?
    
        /// PagingInformation
        public let meta: PagingInformation?
    }
}

/// MARK: BetaGroup.Relationships.App
extension BetaGroup.Relationships.App {
    
    public struct Data: Codable {
    
        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// The resource type.Value: apps
        public let type: String = "apps"
    }
    
    public struct Links: Codable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}

/// MARK: BetaGroup.Relationships.BetaTesters
extension BetaGroup.Relationships.BetaTesters {
    
    public struct Data: Codable {
    
        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// The resource type.Value: betaTesters
        public let type: String = "betaTesters"
    }
    
    public struct Links: Codable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}

/// MARK: BetaGroup.Relationships.Builds
extension BetaGroup.Relationships.Builds {
    
    public struct Data: Codable {
    
        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// The resource type.Value: builds
        public let type: String = "builds"
    }
    
    public struct Links: Codable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}
