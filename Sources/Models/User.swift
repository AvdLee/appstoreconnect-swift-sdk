//
//  User.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
struct User: Decodable {

    /// The resource's attributes.
    let attributes: User.Attributes?

    /// (Required) The opaque resource ID that uniquely identifies the resource.
    let `id`: String

    /// Navigational links to related data and included resource types and IDs.
    let relationships: User.Relationships?

    /// (Required) The resource type.Value: users
    let type: String

    /// (Required) Navigational links that include the self-link.
    let links: ResourceLinks

    /// Attributes that describe a resource.
    struct Attributes: Decodable {
    
        /// The user's first name.
        let firstName: String?
    
        /// The user's last name.
        let lastName: String?
    
        /// Assigned user roles that determine the user's access to sections of App Store Connect and tasks they can perform.
        let roles: [UserRole]?
    
        /// A Boolean value that indicates the user's specified role allows access to the provisioning functionality on the Apple Developer website.
        let provisioningAllowed: Bool?
    
        /// A Boolean value that indicates whether a user has access to all apps available to the team.
        let allAppsVisible: Bool?
    
        /// The user's Apple ID.
        let username: String?
    }
    
    struct Relationships: Decodable {
    
        /// User.Relationships.VisibleApps
        let visibleApps: User.Relationships.VisibleApps?
    }
}

/// MARK: User.Relationships
extension User.Relationships {
    
    struct VisibleApps: Decodable {
    
        /// [User.Relationships.VisibleApps.Data]
        let data: [User.Relationships.VisibleApps.Data]?
    
        /// User.Relationships.VisibleApps.Links
        let links: User.Relationships.VisibleApps.Links?
    
        /// PagingInformation
        let meta: PagingInformation?
    }
}

/// MARK: User.Relationships.VisibleApps
extension User.Relationships.VisibleApps {
    
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
