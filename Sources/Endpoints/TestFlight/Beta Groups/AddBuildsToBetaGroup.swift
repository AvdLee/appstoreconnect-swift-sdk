//
//  AddBuildsToBetaGroup.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

import Foundation
import Alamofire

extension APIEndpoint where T == Void {

    /// Associate builds with a beta group to enable the group to test the builds.
    ///
    /// - Parameters:
    ///   - buildIds: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func add(
        buildsWithIds buildIds: [String],
        toBetaGroupWithId id: String) -> APIEndpoint {
        let request = BetaGroupBuildsLinkagesRequest(buildIds)
        return APIEndpoint(
            path: "betaGroups/\(id)/relationships/builds",
            method: .post,
            parameters: nil,
            body: try? JSONEncoder().encode(request))
    }
}
