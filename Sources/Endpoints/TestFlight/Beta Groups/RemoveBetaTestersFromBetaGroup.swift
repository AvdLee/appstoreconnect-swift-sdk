//
//  RemoveBetaTestersFromBetaGroup.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

import Foundation

extension APIEndpoint where Request == BetaGroupBetaTestersLinkagesRequest, Response == IrrelevantResponse {

    /// Remove a specific beta tester from a one or more beta groups, revoking their access to test builds associated with those groups.
    ///
    /// - Parameters:
    ///   - betaTesterIds: Array of opaque resource ID that uniquely identifies the resources.
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func remove(
        betaTestersWithIds betaTesterIds: [String],
        fromBetaGroupWithId id: String) -> APIEndpoint {
        let request = BetaGroupBetaTestersLinkagesRequest(betaTesterIds)
        return APIEndpoint(
            path: "betaGroups/\(id)/relationships/betaTesters",
            method: .delete,
            parameters: nil,
            body: request
        )
    }
}
