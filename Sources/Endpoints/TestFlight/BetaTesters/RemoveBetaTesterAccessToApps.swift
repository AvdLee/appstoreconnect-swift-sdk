//
//  RemoveBetaTesterAccessToApps.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//

import Foundation

extension APIEndpoint where Request == BetaTesterAppsLinkagesRequest, Response == IrrelevantResponse {

    /// Remove a specific beta tester's access to test any builds of one or more apps.
    ///
    /// - Parameters:
    ///   - id: An opaque resource ID that uniquely identifies the resource.
    ///   - appIds: Array of opaque resource ID that uniquely identifies the resources.
    public static func remove(
        accessOfBetaTesterWithId id: String,
        toAppsWithIds appIds: [String]) -> APIEndpoint {
        let linkages = BetaTesterAppsLinkagesRequest(appIds)
        return APIEndpoint(
            path: "betaTesters/\(id)/relationships/apps",
            method: .delete,
            parameters: nil,
            body: linkages)
    }
}
