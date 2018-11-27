//
//  User.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
public struct User: Codable {

    /// The resource's attributes.
    public let attributes: User.Attributes?

    /// (Required) The opaque resource ID that uniquely identifies the resource.
    public let `id`: String

    /// Navigational links to related data and included resource types and IDs.
    public let relationships: User.Relationships?

    /// (Required) The resource type.Value: users
    public let type: String

    /// (Required) Navigational links that include the self-link.
    public let links: ResourceLinks<UserResponse>

    /// Attributes that describe a resource.
    public struct Attributes: Codable {
    
        /// The user's first name.
        public let firstName: String?
    
        /// The user's last name.
        public let lastName: String?
    
        /// Assigned user roles that determine the user's access to sections of App Store Connect and tasks they can perform.
        public let roles: [UserRole]?
    
        /// A Boolean value that indicates the user's specified role allows access to the provisioning functionality on the Apple Developer website.
        public let provisioningAllowed: Bool?
    
        /// A Boolean value that indicates whether a user has access to all apps available to the team.
        public let allAppsVisible: Bool?
    
        /// The user's Apple ID.
        public let username: String?
    }
    
    public struct Relationships: Codable {
    
        /// User.Relationships.VisibleApps
        public let visibleApps: User.Relationships.VisibleApps?
    }
}

/// MARK: User.Relationships
extension User.Relationships {
    
    public struct VisibleApps: Codable {
    
        /// [User.Relationships.VisibleApps.Data]
        public let data: [User.Relationships.VisibleApps.Data]?
    
        /// User.Relationships.VisibleApps.Links
        public let links: User.Relationships.VisibleApps.Links?
    
        /// PagingInformation
        public let meta: PagingInformation?
    }
}

/// MARK: User.Relationships.VisibleApps
extension User.Relationships.VisibleApps {
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: apps
        public let type: String
    }
    
    public struct Links: Codable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}
