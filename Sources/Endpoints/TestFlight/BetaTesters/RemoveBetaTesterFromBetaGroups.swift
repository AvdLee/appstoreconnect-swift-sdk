//
//  RemoveBetaTesterFromBetaGroups.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//

import Foundation
import Alamofire

extension APIEndpoint where T == Void {

    /// Remove a specific beta tester from one or more beta groups, revoking their access to test builds associated with those groups.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func remove(
        betaTester: BetaTesterBetaGroupsLinkagesRequest,
        fromBetaGroupWithId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "betaTesters/\(id)/relationships/betaGroups",
            method: .delete,
            parameters: nil,
            body: try? JSONEncoder().encode(betaTester))
    }
}
