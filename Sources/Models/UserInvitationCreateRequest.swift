//
//  UserInvitationCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
struct UserInvitationCreateRequest: Decodable {

    /// (Required) The resource data.
    let data: UserInvitationCreateRequest.Data
    
    struct Data: Decodable {
    
        /// (Required) The resource's attributes.
        let attributes: UserInvitationCreateRequest.Data.Attributes
    
        /// The types and IDs of the related data to update.
        let relationships: UserInvitationCreateRequest.Data.Relationships?
    
        /// (Required) The resource type.Value: userInvitations
        let type: String
    }
}

extension UserInvitationCreateRequest.Data {
    /// Attributes that describe a resource.
    struct Attributes: Decodable {
    
        /// A Boolean value that indicates whether a user has access to all apps available to the team.
        let allAppsVisible: Bool?
    
        /// (Required) The email address of a pending user invitation. The email address must be valid to activate the account. It can be any email address, not necessarily one associated with an Apple ID.
        let email: String
    
        /// (Required) The user invitation recipient's first name.
        let firstName: String
    
        /// (Required) The user invitation recipient's last name.
        let lastName: String
    
        /// A Boolean value that indicates the user's specified role allows access to the provisioning functionality on the Apple Developer website.
        let provisioningAllowed: Bool?
    
        /// (Required) Assigned user roles that determine the user's access to sections of App Store Connect and tasks they can perform.
        let roles: [UserRole]
    }
    
    struct Relationships: Decodable {
    
        /// UserInvitationCreateRequest.Data.Relationships.VisibleApps
        let visibleApps: UserInvitationCreateRequest.Data.Relationships.VisibleApps?
    }
}

extension UserInvitationCreateRequest.Data.Relationships {
    
    struct VisibleApps: Decodable {
    
        /// [UserInvitationCreateRequest.Data.Relationships.VisibleApps.Data]
        let data: [UserInvitationCreateRequest.Data.Relationships.VisibleApps.Data]?
    }
}

extension UserInvitationCreateRequest.Data.Relationships.VisibleApps {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: apps
        let type: String
    }
}
