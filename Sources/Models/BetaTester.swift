//
//  BetaTester.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
struct BetaTester: Decodable {

    /// The resource's attributes.
    let attributes: BetaTester.Attributes?

    /// (Required) The opaque resource ID that uniquely identifies the resource.
    let `id`: String

    /// Navigational links to related data and included resource types and IDs.
    let relationships: BetaTester.Relationships?

    /// (Required) The resource type.Value: betaTesters
    let type: String

    /// (Required) Navigational links that include the self-link.
    let links: ResourceLinks

    /// Attributes that describe a resource.
    struct Attributes: Decodable {
    
        /// The beta tester's email address, used for sending beta testing invitations.
        let email: String?
    
        /// The beta tester's first name.
        let firstName: String?
    
        /// An invite type that indicates if a beta tester was invited by an email invite or used a TestFlight public link to join a beta test.
        let inviteType: BetaInviteType?
    
        /// The beta tester's last name.
        let lastName: String?
    }
    
    struct Relationships: Decodable {
    
        /// BetaTester.Relationships.Apps
        let apps: BetaTester.Relationships.Apps?
    
        /// BetaTester.Relationships.BetaGroups
        let betaGroups: BetaTester.Relationships.BetaGroups?
    
        /// BetaTester.Relationships.Builds
        let builds: BetaTester.Relationships.Builds?
    }
}

extension BetaTester.Relationships {
    
    struct Apps: Decodable {
    
        /// [BetaTester.Relationships.Apps.Data]
        let data: [BetaTester.Relationships.Apps.Data]?
    
        /// BetaTester.Relationships.Apps.Links
        let links: BetaTester.Relationships.Apps.Links?
    
        /// PagingInformation
        let meta: PagingInformation?
    }
    
    struct BetaGroups: Decodable {
    
        /// [BetaTester.Relationships.BetaGroups.Data]
        let data: [BetaTester.Relationships.BetaGroups.Data]?
    
        /// BetaTester.Relationships.BetaGroups.Links
        let links: BetaTester.Relationships.BetaGroups.Links?
    
        /// PagingInformation
        let meta: PagingInformation?
    }
    
    struct Builds: Decodable {
    
        /// [BetaTester.Relationships.Builds.Data]
        let data: [BetaTester.Relationships.Builds.Data]?
    
        /// BetaTester.Relationships.Builds.Links
        let links: BetaTester.Relationships.Builds.Links?
    
        /// PagingInformation
        let meta: PagingInformation?
    }
}

extension BetaTester.Relationships.Apps {
    
    struct Data: Decodable {
    
        /// string (Required)
        let `id`: String
    
        /// string (Required)Value: apps
        let type: String
    }
    
    struct Links: Decodable {
    
        /// uri-reference
        let related: URL?
    
        /// uri-reference
        let `self`: URL?
    }
}

extension BetaTester.Relationships.BetaGroups {
    
    struct Data: Decodable {
    
        /// string (Required)
        let `id`: String
    
        /// string (Required)Value: betaGroups
        let type: String
    }
    
    struct Links: Decodable {
    
        /// uri-reference
        let related: URL?
    
        /// uri-reference
        let `self`: URL?
    }
}

extension BetaTester.Relationships.Builds {
    
    struct Data: Decodable {
    
        /// string (Required)
        let `id`: String
    
        /// string (Required)Value: builds
        let type: String
    }
    
    struct Links: Decodable {
    
        /// uri-reference
        let related: URL?
    
        /// uri-reference
        let `self`: URL?
    }
}
