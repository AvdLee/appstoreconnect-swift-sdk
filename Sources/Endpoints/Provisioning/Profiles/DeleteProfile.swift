//
//  DeleteProfile.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/24/19.
//

import Foundation

extension APIEndpoint where Request == EmptyBody, Response == IrrelevantResponse {

    /// Delete a provisioning profile that is used for app development or distribution.
    public static func delete(profileWithId id: String) -> APIEndpoint {

        return APIEndpoint(
            path: "profiles/\(id)",
            method: .delete,
            parameters: nil)
    }
}
