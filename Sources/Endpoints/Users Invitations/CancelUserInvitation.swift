//
//  CancelUserInvitation.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where Request == EmptyBody, Response == IrrelevantResponse {

    /// Cancel a pending invitation for a user to join your team.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func cancel(userInvitationWithId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "userInvitations/\(id)",
            method: .delete,
            parameters: nil)
    }
}
