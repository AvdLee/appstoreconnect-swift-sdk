//
//  UnassignBetaTesterFromBuilds.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//

import Foundation
import Alamofire

extension APIEndpoint where T == Void {

    /// Remove an individually assigned beta tester's ability to test a build.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func unassign(
        betaTester: BetaTesterBuildsLinkagesRequest,
        fromBuildWithId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "betaTesters/\(id)/relationships/builds",
            method: .delete,
            parameters: nil,
            body: try? JSONEncoder().encode(betaTester))
    }
}
