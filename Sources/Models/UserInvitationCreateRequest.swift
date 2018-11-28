//
//  UserInvitationCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
public struct UserInvitationCreateRequest: Codable {

    /// - Parameters:
    ///   - email: The email address of a pending user invitation. The email address must be valid to activate the account. It can be any email address, not necessarily one associated with an Apple ID.
    ///   - firstName: The user invitation recipient's first name.
    ///   - lastName: The user invitation recipient's last name.
    ///   - roles: Assigned user roles that determine the user's access to sections of App Store Connect and tasks they can perform.
    ///   - allAppsVisible: A Boolean value that indicates whether a user has access to all apps available to the team.
    ///   - provisioningAllowed: A Boolean value that indicates the user's specified role allows access to the provisioning functionality on the Apple Developer website.
    ///   - appsVisibleIds: Array of opaque resource ID that uniquely identifies the resources.
    init(email: String,
                firstName: String,
                lastName: String,
                roles: [UserRole],
                allAppsVisible: Bool? = nil,
                provisioningAllowed: Bool? = nil,
                appsVisibleIds: [String]?) {
        data = .init(
            attributes: .init(
                allAppsVisible: allAppsVisible,
                email: email,
                firstName: firstName,
                lastName: lastName,
                provisioningAllowed: provisioningAllowed,
                roles: roles),
            relationships: .init(visibleApps: .init(data: appsVisibleIds?.map({ Data.Relationships.VisibleApps.Data(id: $0) }))))
    }
    
    /// (Required) The resource data.
    public let data: UserInvitationCreateRequest.Data
    
    public struct Data: Codable {
    
        /// (Required) The resource's attributes.
        public let attributes: UserInvitationCreateRequest.Data.Attributes
    
        /// The types and IDs of the related data to update.
        public let relationships: UserInvitationCreateRequest.Data.Relationships?
    
        /// (Required) The resource type.Value: userInvitations
        public let type: String = "userInvitations"
    }
}

/// MARK: UserInvitationCreateRequest.Data
extension UserInvitationCreateRequest.Data {
    /// Attributes that describe a resource.
    public struct Attributes: Codable {
    
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
    
    public struct Relationships: Codable {
    
        /// UserInvitationCreateRequest.Data.Relationships.VisibleApps
        public let visibleApps: UserInvitationCreateRequest.Data.Relationships.VisibleApps?
    }
}

/// MARK: UserInvitationCreateRequest.Data.Relationships
extension UserInvitationCreateRequest.Data.Relationships {
    
    public struct VisibleApps: Codable {
    
        /// [UserInvitationCreateRequest.Data.Relationships.VisibleApps.Data]
        public let data: [UserInvitationCreateRequest.Data.Relationships.VisibleApps.Data]?
    }
}

/// MARK: UserInvitationCreateRequest.Data.Relationships.VisibleApps
extension UserInvitationCreateRequest.Data.Relationships.VisibleApps {
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: apps
        public let type: String = "apps"
    }
}
