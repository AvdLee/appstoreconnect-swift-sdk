//
//  ModifyBetaGroup.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

import Foundation

extension APIEndpoint where T == BetaGroupResponse {

    /// Modify a beta group's metadata, including changing its Testflight public link status.
    ///
    /// - Parameters:
    ///   - id: The opaque resource ID that uniquely identifies the resource.
    ///   - name: The name for the beta group.
    ///   - publicLinkEnabled: A Boolean value that indicates whether a public link is enabled. Enabling a link allows you to invite anyone outside of your team to beta test your app. When you share this link, testers will be able to install the beta version of your app on their devices in TestFlight and share the link with others.
    ///   - publicLinkLimit: The maximum number of testers that can join this beta group using the public link. Values must be between 1 and 10,000.
    ///   - publicLinkLimitEnabled: A Boolean value that limits the number of testers who can join the beta group using the public link.
    public static func modify(
        betaGroupWithId id: String,
        name: String? = nil,
        publicLinkEnabled: Bool? = nil,
        publicLinkLimit: Int? = nil,
        publicLinkLimitEnabled: Bool? = nil) -> APIEndpoint {
        let request = BetaGroupUpdateRequest(
            id: id,
            name: name,
            publicLinkEnabled: publicLinkEnabled,
            publicLinkLimit: publicLinkLimit,
            publicLinkLimitEnabled: publicLinkLimitEnabled)
        return APIEndpoint(
            path: "betaGroups/\(id)",
            method: .patch,
            parameters: nil,
            body: request.erased)
    }
}
