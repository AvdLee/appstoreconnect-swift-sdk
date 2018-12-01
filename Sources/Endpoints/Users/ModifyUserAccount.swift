//
//  ModifyUserAccount.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

import Foundation
import Alamofire

extension APIEndpoint where T == UserResponse {

    /// Change a user's role, app visibility information, or other account details.
    ///
    /// - Parameters:
    ///   - id: The opaque resource ID that uniquely identifies the resource.
    ///   - allAppsVisible: Assigned user roles that determine the user's access to sections of App Store Connect and tasks they can perform.
    ///   - provisioningAllowed: A Boolean value that indicates the user's specified role allows access to the provisioning functionality on the Apple Developer website.
    ///   - roles: Assigned user roles that determine the user's access to sections of App Store Connect and tasks they can perform.
    ///   - appsVisibleIds: Array of opaque resource ID that uniquely identifies the resources.
    public static func modify(
        userWithId id: String,
        allAppsVisible: Bool? = nil,
        provisioningAllowed: Bool? = nil,
        roles: [UserRole]? = nil,
        appsVisibleIds: [String]? = nil) -> APIEndpoint {
        let request = UserUpdateRequest(
            id: id,
            allAppsVisible: allAppsVisible,
            provisioningAllowed: provisioningAllowed,
            roles: roles,
            appsVisibleIds: appsVisibleIds)
        return APIEndpoint(
            path: "users/\(id)",
            method: .patch,
            parameters: nil,
            body: try? JSONEncoder().encode(request))
    }
}
