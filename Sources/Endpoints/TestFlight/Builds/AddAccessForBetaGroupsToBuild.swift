//
//  AddAccessForBetaGroupsToBuild.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

import Foundation

extension APIEndpoint where T == Void {

    /// Add or create a beta group to a build to enable testing.
    ///
    /// - Parameters:
    ///   - betaGroupIds: Array of opaque resource ID that uniquely identifies the resources.
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func add(
        accessForBetaGroupsWithIds betaGroupIds: [String],
        toBuildWithId id: String) -> APIEndpoint {
        let request = BuildBetaGroupsLinkagesRequest(betaGroupIds)
        return APIEndpoint(
            path: "builds/\(id)/relationships/betaGroups",
            method: .post,
            parameters: nil,
            body: request.erased)
    }
}
