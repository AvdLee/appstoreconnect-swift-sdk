//
//  AssignIndividualTestersToBuild.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

import Foundation

extension APIEndpoint where Request == BuildIndividualTestersLinkagesRequest, Response == IrrelevantResponse {

    /// Enable a beta tester who is not a part of a beta group to test a build.
    ///
    /// - Parameters:
    ///   - betaTesterIds: Array of opaque resource ID that uniquely identifies the resources.
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func assign(
        individualTestersWithIds betaTesterIds: [String],
        toBuildWithId id: String) -> APIEndpoint {
        let request = BuildIndividualTestersLinkagesRequest(betaTesterIds)
        return APIEndpoint(
            path: "builds/\(id)/relationships/individualTesters",
            method: .post,
            parameters: nil,
            body: request)
    }
}
