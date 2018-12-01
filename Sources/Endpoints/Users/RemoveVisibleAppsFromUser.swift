//
//  RemoveVisibleAppsFromUser.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

import Foundation
import Alamofire

extension APIEndpoint where T == Void {

    /// Remove a user on your team’s access to one or more apps.
    ///
    /// - Parameters:
    ///   - appIds: Array of opaque resource ID that uniquely identifies the resources.
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func remove(
        visibleAppsWithIds appIds: [String],
        fromUserWithId id: String) -> APIEndpoint {
        let request = UserVisibleAppsLinkagesRequest(appIds)
        return APIEndpoint(
            path: "users/\(id)/relationships/visibleApps",
            method: .delete,
            parameters: nil,
            body: try? JSONEncoder().encode(request))
    }
}
