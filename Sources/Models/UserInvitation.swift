//
//  UserInvitation.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
public struct UserInvitation: Codable {

    /// The resource's attributes.
    public let attributes: UserInvitation.Attributes?

    /// (Required) The opaque resource ID that uniquely identifies the resource.
    public let `id`: String

    /// Navigational links to related data and included resource types and IDs.
    public let relationships: UserInvitation.Relationships?

    /// (Required) The resource type.Value: userInvitations
    public let type: String = "userInvitations"

    /// (Required) Navigational links that include the self-link.
    public let links: ResourceLinks<UserInvitationResponse>

    /// Attributes that describe a resource.
    public struct Attributes: Codable {
    
        /// The email address of a pending user invitation. The email address must be valid to activate the account. It can be any email address, not necessarily one associated with an Apple ID.
        public let email: String?
    
        /// The first name of the user with the pending user invitation.
        public let firstName: String?
    
        /// The last name of the user with the pending user invitation.
        public let lastName: String?
    
        /// Assigned user roles that determine the user's access to sections of App Store Connect and tasks they can perform.
        public let roles: [UserRole]?
    
        /// The expiration date of the pending invitation.
        public let expirationDate: Date?
    
        /// A Boolean value that indicates the user's specified role allows access to the provisioning functionality on the Apple Developer website.
        public let provisioningAllowed: Bool?
    
        /// A Boolean value that indicates whether a user has access to all apps available to the team.
        public let allAppsVisible: Bool?
    }
    
    public struct Relationships: Codable {
    
        /// UserInvitation.Relationships.VisibleApps
        public let visibleApps: UserInvitation.Relationships.VisibleApps?
    }
}

/// MARK: UserInvitation.Relationships
extension UserInvitation.Relationships {
    
    public struct VisibleApps: Codable {
    
        /// [UserInvitation.Relationships.VisibleApps.Data]
        public let data: [UserInvitation.Relationships.VisibleApps.Data]?
    
        /// UserInvitation.Relationships.VisibleApps.Links
        public let links: UserInvitation.Relationships.VisibleApps.Links?
    
        /// PagingInformation
        public let meta: PagingInformation?
    }
}

/// MARK: UserInvitation.Relationships.VisibleApps
extension UserInvitation.Relationships.VisibleApps {
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: apps
        public let type: String = " apps"
    }
    
    public struct Links: Codable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}
