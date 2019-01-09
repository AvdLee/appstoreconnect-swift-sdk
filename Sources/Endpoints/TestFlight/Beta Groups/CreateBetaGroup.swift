//
//  CreateBetaGroup.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

import Foundation
import Alamofire

extension APIEndpoint where T == BetaGroupResponse {

    /// Create a beta group associated with an app, optionally enabling TestFlight public links.
    ///
    /// - Parameters:
    ///   - appId: The opaque resource ID that uniquely identifies the resource.
    ///   - name: The name for the beta group.
    ///   - publicLinkEnabled: A Boolean value that indicates whether a public link is enabled. Enabling a link allows you to invite anyone outside of your team to beta test your app. When you share this link, testers will be able to install the beta version of your app on their devices in TestFlight and share the link with others.
    ///   - publicLinkLimit: The maximum number of testers that can join this beta group using the public link. Values must be between 1 and 10,000.
    ///   - publicLinkLimitEnabled: A Boolean value that limits the number of testers who can join the beta group using the public link.
    ///   - betaTesterIds: Array of opaque resource ID that uniquely identifies the resources.
    ///   - buildIds: Array of opaque resource ID that uniquely identifies the resources.
    public static func create(
        betaGroupForAppWithId appId: String,
        name: String,
        publicLinkEnabled: Bool? = nil,
        publicLinkLimit: Int? = nil,
        publicLinkLimitEnabled: Bool? = nil,
        betaTesterIds: [String]? = [],
        buildIds: [String]? = []) -> APIEndpoint {
        let request = BetaGroupCreateRequest(
            appId: appId,
            name: name,
            publicLinkEnabled: publicLinkEnabled,
            publicLinkLimit: publicLinkLimit,
            publicLinkLimitEnabled: publicLinkLimitEnabled,
            betaTesterIds: betaTesterIds,
            buildIds: buildIds)
        return APIEndpoint(
            path: "betaGroups",
            method: .post,
            parameters: nil,
            body: try? JSONEncoder().encode(request))
    }
}
