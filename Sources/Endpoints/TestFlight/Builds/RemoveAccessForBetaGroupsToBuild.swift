//
//  RemoveAccessForBetaGroupsToBuild.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

import Foundation
import Alamofire

extension APIEndpoint where T == Void {

    /// Remove access to a specific build for all beta testers in one or more beta groups.
    ///
    /// - Parameters:
    ///   - betaGroupIds: Array of opaque resource ID that uniquely identifies the resources.
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func remove(
        accessForBetaGroupsWithIds betaGroupIds: [String],
        toBuildWithId id: String) -> APIEndpoint {
        let request = BuildBetaGroupsLinkagesRequest(betaGroupIds)
        return APIEndpoint(
            path: "builds/\(id)/relationships/betaGroups",
            method: .delete,
            parameters: nil,
            body: try? JSONEncoder().encode(request))
    }
}
