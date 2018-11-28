//
//  AssignBetaTesterToBuilds.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//

import Foundation
import Alamofire

extension APIEndpoint where T == Void {

    /// Individually assign a beta tester to a build.
    ///
    /// - Parameters:
    ///   - betaTesterBuildsLinkages: A request containing the IDs of related resources.
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func assign(
        betaTesterWithId id: String,
        toBuildsWithIds buildIds: [String]) -> APIEndpoint {
        let linkages = BetaTesterBuildsLinkagesRequest(buildIds)
        return APIEndpoint(path: "betaTesters/\(id)/relationships/builds",
            method: .post,
            parameters: nil,
            body: try? JSONEncoder().encode(linkages))
    }
}
