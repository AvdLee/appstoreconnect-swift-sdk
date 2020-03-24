//
//  RemoveUserAccount.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where Request == EmptyBody, Response == IrrelevantResponse {

    /// Remove a user from your team.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func remove(userWithId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "users/\(id)",
            method: .delete,
            parameters: nil)
    }
}
