//
//  ReplaceListOfVisibleAppsForUser.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

import Foundation

extension APIEndpoint where T == Void {

    /// Replace the list of apps a user on your team can see.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - appIds: Array of opaque resource ID that uniquely identifies the resources.
    public static func replaceListOfVisibleApps(
        forUserWithId id: String,
        withAppsWithIds appIds: [String]) -> APIEndpoint {
        let request = UserVisibleAppsLinkagesRequest(appIds)
        return APIEndpoint(
            path: "users/\(id)/relationships/visibleApps",
            method: .patch,
            parameters: nil,
            body: try? JSONEncoder().encode(request))
    }
}
