//
//  AddVisibleAppsToUser.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

import Foundation

extension APIEndpoint where T == Void {

    /// Give a user on your team access to one or more apps.
    ///
    /// - Parameters:
    ///   - appIds: Array of opaque resource ID that uniquely identifies the resources.
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func add(
        visibleAppsWithIds appIds: [String],
        toUserWithId id: String) -> APIEndpoint {
        let request = UserVisibleAppsLinkagesRequest(appIds)
        return APIEndpoint(
            path: "users/\(id)/relationships/visibleApps",
            method: .post,
            parameters: nil,
            body: request.erased)
    }
}
