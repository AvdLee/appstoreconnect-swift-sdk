//
//  AddBetaTesterToBetaGroups.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//

import Foundation
import Alamofire

extension APIEndpoint where T == Void {

    /// Add one or more beta testers to a specific beta group.
    ///
    /// - Parameters:
    ///   - betaTesterBetaGroupsLinkages: A request containing the IDs of related resources.
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func add(
        betaTesterWithId id: String,
        toBetaGroupWithId betaGroupIds: [String]) -> APIEndpoint {
        let linkages = BetaTesterBetaGroupsLinkagesRequest(betaGroupIds)
        return APIEndpoint(
            path: "betaTesters/\(id)/relationships/betaGroups",
            method: .post,
            parameters: nil,
            body: try? JSONEncoder().encode(linkages))
    }
}
