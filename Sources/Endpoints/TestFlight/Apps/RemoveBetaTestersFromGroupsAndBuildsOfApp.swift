//
//  RemoveBetaTestersFromGroupsAndBuildsOfApp.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//

import Foundation

extension APIEndpoint where Request == AppBetaTestersLinkagesRequest, Response == IrrelevantResponse {

    /// Remove one or more beta testers' access to test any builds of a specific app.
    ///
    /// - Parameters:
    ///   - betaTesterIds: Array of opaque resource ID that uniquely identifies the resources.
    ///   - id: An opaque resource ID that uniquely identifies the resource.
    public static func remove(
        betaTestersWithIds betaTesterIds: [String],
        fromGroupsAndBuildsOfAppWithId id: String) -> APIEndpoint {
        let linkages = AppBetaTestersLinkagesRequest(betaTesterIds)
        return APIEndpoint(
            path: "apps/\(id)/relationships/betaTesters",
            method: .delete,
            parameters: nil,
            body: linkages)
    }
}
