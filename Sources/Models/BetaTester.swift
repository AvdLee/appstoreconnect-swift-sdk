//
//  BetaTester.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
public struct BetaTester: Decodable {

    /// The resource's attributes.
    public let attributes: BetaTester.Attributes?

    /// (Required) The opaque resource ID that uniquely identifies the resource.
    public let `id`: String

    /// Navigational links to related data and included resource types and IDs.
    public let relationships: BetaTester.Relationships?

    /// (Required) The resource type.Value: betaTesters
    public let type: String

    /// (Required) Navigational links that include the self-link.
    public let links: ResourceLinks

    /// Attributes that describe a resource.
    public struct Attributes: Decodable {
    
        /// The beta tester's email address, used for sending beta testing invitations.
        public let email: String?
    
        /// The beta tester's first name.
        public let firstName: String?
    
        /// An invite type that indicates if a beta tester was invited by an email invite or used a TestFlight public link to join a beta test.
        public let inviteType: BetaInviteType?
    
        /// The beta tester's last name.
        public let lastName: String?
    }
    
    public struct Relationships: Decodable {
    
        /// BetaTester.Relationships.Apps
        public let apps: BetaTester.Relationships.Apps?
    
        /// BetaTester.Relationships.BetaGroups
        public let betaGroups: BetaTester.Relationships.BetaGroups?
    
        /// BetaTester.Relationships.Builds
        public let builds: BetaTester.Relationships.Builds?
    }
}

/// MARK: BetaTester.Relationships
extension BetaTester.Relationships {
    
    public struct Apps: Decodable {
    
        /// [BetaTester.Relationships.Apps.Data]
        public let data: [BetaTester.Relationships.Apps.Data]?
    
        /// BetaTester.Relationships.Apps.Links
        public let links: BetaTester.Relationships.Apps.Links?
    
        /// PagingInformation
        public let meta: PagingInformation?
    }
    
    public struct BetaGroups: Decodable {
    
        /// [BetaTester.Relationships.BetaGroups.Data]
        public let data: [BetaTester.Relationships.BetaGroups.Data]?
    
        /// BetaTester.Relationships.BetaGroups.Links
        public let links: BetaTester.Relationships.BetaGroups.Links?
    
        /// PagingInformation
        public let meta: PagingInformation?
    }
    
    public struct Builds: Decodable {
    
        /// [BetaTester.Relationships.Builds.Data]
        public let data: [BetaTester.Relationships.Builds.Data]?
    
        /// BetaTester.Relationships.Builds.Links
        public let links: BetaTester.Relationships.Builds.Links?
    
        /// PagingInformation
        public let meta: PagingInformation?
    }
}

/// MARK: BetaTester.Relationships.Apps
extension BetaTester.Relationships.Apps {
    
    public struct Data: Decodable {
    
        /// string (Required)
        public let `id`: String
    
        /// string (Required)Value: apps
        public let type: String
    }
    
    public struct Links: Decodable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}

/// MARK: BetaTester.Relationships.BetaGroups
extension BetaTester.Relationships.BetaGroups {
    
    public struct Data: Decodable {
    
        /// string (Required)
        public let `id`: String
    
        /// string (Required)Value: betaGroups
        public let type: String
    }
    
    public struct Links: Decodable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}

/// MARK: BetaTester.Relationships.Builds
extension BetaTester.Relationships.Builds {
    
    public struct Data: Decodable {
    
        /// string (Required)
        public let `id`: String
    
        /// string (Required)Value: builds
        public let type: String
    }
    
    public struct Links: Decodable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}
