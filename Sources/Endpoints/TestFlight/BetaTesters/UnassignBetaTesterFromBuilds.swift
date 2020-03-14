//
//  UnassignBetaTesterFromBuilds.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//

import Foundation

extension APIEndpoint where T == Void {

    /// Remove an individually assigned beta tester's ability to test a build.
    ///
    /// - Parameters:
    ///   - id: An opaque resource ID that uniquely identifies the resource.
    ///   - betaGroupIds: Array of opaque resource ID that uniquely identifies the resources.
    public static func unassign(
        betaTesterWithId id: String,
        fromBuildsWithIds buildIds: [String]) -> APIEndpoint {
        let linkages = BetaTesterBuildsLinkagesRequest(buildIds)
        return APIEndpoint(
            path: "betaTesters/\(id)/relationships/builds",
            method: .delete,
            parameters: nil,
            body: linkages.erased)
    }
}
