//
//  UserInvitation.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
struct UserInvitation: Decodable {

    /// The resource's attributes.
    let attributes: UserInvitation.Attributes?

    /// (Required) The opaque resource ID that uniquely identifies the resource.
    let `id`: String

    /// Navigational links to related data and included resource types and IDs.
    let relationships: UserInvitation.Relationships?

    /// (Required) The resource type.Value: userInvitations
    let type: String

    /// (Required) Navigational links that include the self-link.
    let links: ResourceLinks

}

extension UserInvitation {
    /// Attributes that describe a resource.
    struct Attributes: Decodable {
    
        /// The email address of a pending user invitation. The email address must be valid to activate the account. It can be any email address, not necessarily one associated with an Apple ID.
        let email: String?
    
        /// The first name of the user with the pending user invitation.
        let firstName: String?
    
        /// The last name of the user with the pending user invitation.
        let lastName: String?
    
        /// Assigned user roles that determine the user's access to sections of App Store Connect and tasks they can perform.
        let roles: [UserRole]?
    
        /// The expiration date of the pending invitation.
        let expirationDate: Date?
    
        /// A Boolean value that indicates the user's specified role allows access to the provisioning functionality on the Apple Developer website.
        let provisioningAllowed: Bool?
    
        /// A Boolean value that indicates whether a user has access to all apps available to the team.
        let allAppsVisible: Bool?
    
    }
}

extension UserInvitation {
    
    struct Relationships: Decodable {
    
        /// UserInvitation.Relationships.VisibleApps
        let visibleApps: UserInvitation.Relationships.VisibleApps?
    
    }
}

extension UserInvitation.Relationships {
    
    struct VisibleApps: Decodable {
    
        /// [UserInvitation.Relationships.VisibleApps.Data]
        let data: [UserInvitation.Relationships.VisibleApps.Data]?
    
        /// UserInvitation.Relationships.VisibleApps.Links
        let links: UserInvitation.Relationships.VisibleApps.Links?
    
        /// PagingInformation
        let meta: PagingInformation?
    
    }
}

extension UserInvitation.Relationships.VisibleApps {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: apps
        let type: String
    
    }
}

extension UserInvitation.Relationships.VisibleApps {
    
    struct Links: Decodable {
    
        /// uri-reference
        let related: URL?
    
        /// uri-reference
        let `self`: URL?
    
    }
}
