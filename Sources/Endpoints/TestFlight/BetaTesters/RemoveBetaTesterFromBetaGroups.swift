//
//  RemoveBetaTesterFromBetaGroups.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//

import Foundation

extension APIEndpoint where T == Void {

    /// Remove a specific beta tester from one or more beta groups, revoking their access to test builds associated with those groups.
    ///
    /// - Parameters:
    ///   - id: An opaque resource ID that uniquely identifies the resource.
    ///   - betaGroupIds: Array of opaque resource ID that uniquely identifies the resources.
    public static func remove(
        betaTesterWithId id: String,
        fromBetaGroupsWithIds betaGroupIds: [String]) -> APIEndpoint {
        let linkages = BetaTesterBetaGroupsLinkagesRequest(betaGroupIds)
        return APIEndpoint(
            path: "betaTesters/\(id)/relationships/betaGroups",
            method: .delete,
            parameters: nil,
            body: linkages.erased)
    }
}
