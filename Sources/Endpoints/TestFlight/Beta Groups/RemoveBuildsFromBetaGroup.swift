//
//  RemoveBuildsFromBetaGroup.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

import Foundation

extension APIEndpoint where T == Void {

    /// Remove access to test one or more builds from beta testers in a specific beta group.
    ///
    /// - Parameters:
    ///   - buildIds: Array of opaque resource ID that uniquely identifies the resources.
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func remove(
        buildsWithIds buildIds: [String],
        fromBetaGroupWithId id: String) -> APIEndpoint {
        let request = BetaGroupBuildsLinkagesRequest(buildIds)
        return APIEndpoint(
            path: "betaGroups/\(id)/relationships/builds",
            method: .delete,
            parameters: nil,
            body: request.erased)
    }
}
