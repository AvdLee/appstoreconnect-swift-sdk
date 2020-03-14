//
//  InviteUser.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

import Foundation

extension APIEndpoint where T == UserInvitationResponse {

    /// Invite a user with assigned user roles to join your team.
    ///
    /// - Parameters:
    ///   - email: The email address of a pending user invitation. The email address must be valid to activate the account. It can be any email address, not necessarily one associated with an Apple ID.
    ///   - firstName: The user invitation recipient's first name.
    ///   - lastName: The user invitation recipient's last name.
    ///   - roles: Assigned user roles that determine the user's access to sections of App Store Connect and tasks they can perform.
    ///   - allAppsVisible: A Boolean value that indicates whether a user has access to all apps available to the team.
    ///   - provisioningAllowed: A Boolean value that indicates the user's specified role allows access to the provisioning functionality on the Apple Developer website.
    ///   - appsVisibleIds: Array of opaque resource ID that uniquely identifies the resources.
    public static func invite(
        userWithEmail email: String,
        firstName: String,
        lastName: String,
        roles: [UserRole],
        allAppsVisible: Bool? = nil,
        provisioningAllowed: Bool? = nil,
        appsVisibleIds: [String]? = nil) -> APIEndpoint {
        let request = UserInvitationCreateRequest(
            email: email,
            firstName: firstName,
            lastName: lastName,
            roles: roles,
            allAppsVisible: allAppsVisible,
            provisioningAllowed: provisioningAllowed,
            appsVisibleIds: appsVisibleIds)
        return APIEndpoint(
            path: "userInvitations",
            method: .post,
            parameters: nil,
            body: request.erased)
    }
}
