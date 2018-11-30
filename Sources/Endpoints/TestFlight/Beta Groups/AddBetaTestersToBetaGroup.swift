//
//  AddBetaTestersToBetaGroup.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

import Foundation
import Alamofire

extension APIEndpoint where T == Void {

    /// Add a specific beta tester to one or more beta groups for beta testing.
    ///
    /// - Parameters:
    ///   - betaTesterIds: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func add(
        betaTestersWithIds betaTesterIds: [String],
        toBetaGroupWithId id: String) -> APIEndpoint {
        let request = BetaGroupBetaTestersLinkagesRequest(betaTesterIds)
        return APIEndpoint(
            path: "betaGroups/\(id)/relationships/betaTesters",
            method: .post,
            parameters: nil,
            body: try? JSONEncoder().encode(request))
    }
}
