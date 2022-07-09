//
//  AddBetaTesterToBetaGroups.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//

import Foundation

extension APIEndpoint where T == Void {

    /// Add one or more beta testers to a specific beta group.
    ///
    /// - Parameters:
    ///   - id: An opaque resource ID that uniquely identifies the resource.
    ///   - betaGroupIds: Array of opaque resource ID that uniquely identifies the resources.
    public static func add(
        betaTesterWithId id: String,
        toBetaGroupsWithIds betaGroupIds: [String]) -> APIEndpoint {
        let linkages = BetaTesterBetaGroupsLinkagesRequest(betaGroupIds)
        return APIEndpoint(
            path: "betaTesters/\(id)/relationships/betaGroups",
            method: .post,
            parameters: nil,
            body: try? JSONEncoder().encode(linkages))
    }
}
