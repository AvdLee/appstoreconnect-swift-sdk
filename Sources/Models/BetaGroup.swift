//
//  BetaGroup.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
struct BetaGroup: Decodable {

    /// The resource's attributes.
    let attributes: BetaGroup.Attributes?

    /// (Required) The opaque resource ID that uniquely identifies the resource.
    let `id`: String

    /// Navigational links to related data and included resource types and IDs.
    let relationships: BetaGroup.Relationships?

    /// (Required) The resource type.Value: betaGroups
    let type: String

    /// (Required) Navigational links that include the self-link.
    let links: ResourceLinks

    /// Attributes that describe a resource.
    struct Attributes: Decodable {
    
        /// A Boolean value that indicates whether the group is internal. Only existing users of App Store Connect may be added for internal beta testing.
        let isInternalGroup: Bool?
    
        /// The name for the beta group.
        let name: String?
    
        /// The URL of the public link provided to your app's beta testers.
        let publicLink: String?
    
        /// A Boolean value that indicates whether a public link is enabled. Enabling a link allows you to invite anyone outside of your team to beta test your app. When you share this link, testers will be able to install the beta version of your app on their devices in TestFlight and share the link with others.
        let publicLinkEnabled: Bool?
    
        /// The ID as part of the URL of the public link.
        let publicLinkId: String?
    
        /// The maximum number of testers that can join this beta group using the public link. Values must be between 1 and 10,000.
        let publicLinkLimit: Int?
    
        /// A Boolean value that limits the number of testers who can join the beta group using the public link.
        let publicLinkLimitEnabled: Bool?
    
        /// The creation date of the beta group.
        let createdDate: Date?
    }

    struct Relationships: Decodable {
    
        /// BetaGroup.Relationships.App
        let app: BetaGroup.Relationships.App?
    
        /// BetaGroup.Relationships.BetaTesters
        let betaTesters: BetaGroup.Relationships.BetaTesters?
    
        /// BetaGroup.Relationships.Builds
        let builds: BetaGroup.Relationships.Builds?
    }
}

/// MARK: BetaGroup.Relationships
extension BetaGroup.Relationships {
    
    struct App: Decodable {
    
        /// BetaGroup.Relationships.App.Data
        let data: BetaGroup.Relationships.App.Data?
    
        /// BetaGroup.Relationships.App.Links
        let links: BetaGroup.Relationships.App.Links?
    }
    
    struct BetaTesters: Decodable {
    
        /// [BetaGroup.Relationships.BetaTesters.Data]
        let data: [BetaGroup.Relationships.BetaTesters.Data]?
    
        /// BetaGroup.Relationships.BetaTesters.Links
        let links: BetaGroup.Relationships.BetaTesters.Links?
    
        /// PagingInformation
        let meta: PagingInformation?
    }
    
    struct Builds: Decodable {
    
        /// [BetaGroup.Relationships.Builds.Data]
        let data: [BetaGroup.Relationships.Builds.Data]?
    
        /// BetaGroup.Relationships.Builds.Links
        let links: BetaGroup.Relationships.Builds.Links?
    
        /// PagingInformation
        let meta: PagingInformation?
    }
}

/// MARK: BetaGroup.Relationships.App
extension BetaGroup.Relationships.App {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: apps
        let type: String
    }
    
    struct Links: Decodable {
    
        /// uri-reference
        let related: URL?
    
        /// uri-reference
        let `self`: URL?
    }
}

/// MARK: BetaGroup.Relationships.BetaTesters
extension BetaGroup.Relationships.BetaTesters {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: betaTesters
        let type: String
    }
    
    struct Links: Decodable {
    
        /// uri-reference
        let related: URL?
    
        /// uri-reference
        let `self`: URL?
    }
}

/// MARK: BetaGroup.Relationships.Builds
extension BetaGroup.Relationships.Builds {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: builds
        let type: String
    }
    
    struct Links: Decodable {
    
        /// uri-reference
        let related: URL?
    
        /// uri-reference
        let `self`: URL?
    }
}
