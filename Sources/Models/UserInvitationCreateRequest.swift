//
//  UserInvitationCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
public struct UserInvitationCreateRequest: Decodable {

    /// (Required) The resource data.
    public let data: UserInvitationCreateRequest.Data
    
    public struct Data: Decodable {
    
        /// (Required) The resource's attributes.
        public let attributes: UserInvitationCreateRequest.Data.Attributes
    
        /// The types and IDs of the related data to update.
        public let relationships: UserInvitationCreateRequest.Data.Relationships?
    
        /// (Required) The resource type.Value: userInvitations
        public let type: String
    }
}

/// MARK: UserInvitationCreateRequest.Data
extension UserInvitationCreateRequest.Data {
    /// Attributes that describe a resource.
    public struct Attributes: Decodable {
    
        /// A Boolean value that indicates whether a user has access to all apps available to the team.
        public let allAppsVisible: Bool?
    
        /// (Required) The email address of a pending user invitation. The email address must be valid to activate the account. It can be any email address, not necessarily one associated with an Apple ID.
        public let email: String
    
        /// (Required) The user invitation recipient's first name.
        public let firstName: String
    
        /// (Required) The user invitation recipient's last name.
        public let lastName: String
    
        /// A Boolean value that indicates the user's specified role allows access to the provisioning functionality on the Apple Developer website.
        public let provisioningAllowed: Bool?
    
        /// (Required) Assigned user roles that determine the user's access to sections of App Store Connect and tasks they can perform.
        public let roles: [UserRole]
    }
    
    public struct Relationships: Decodable {
    
        /// UserInvitationCreateRequest.Data.Relationships.VisibleApps
        public let visibleApps: UserInvitationCreateRequest.Data.Relationships.VisibleApps?
    }
}

/// MARK: UserInvitationCreateRequest.Data.Relationships
extension UserInvitationCreateRequest.Data.Relationships {
    
    public struct VisibleApps: Decodable {
    
        /// [UserInvitationCreateRequest.Data.Relationships.VisibleApps.Data]
        public let data: [UserInvitationCreateRequest.Data.Relationships.VisibleApps.Data]?
    }
}

/// MARK: UserInvitationCreateRequest.Data.Relationships.VisibleApps
extension UserInvitationCreateRequest.Data.Relationships.VisibleApps {
    
    public struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: apps
        public let type: String
    }
}
