//
//  CreateBetaTester.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//

import Foundation
import Alamofire

extension APIEndpoint where T == BetaTesterResponse {

    /// Create a beta tester assigned to a group, a build, or an app.
    public static func create(
        betaTesterWithEmail email: String,
        firstName: String? = nil,
        lastName: String? = nil,
        betaGroupIds: [String]? = nil,
        buildIds: [String]? = nil) -> APIEndpoint {
        let betaTester = BetaTesterCreateRequest(
            email: email,
            firstName: firstName,
            lastName: lastName,
            betaGroupIds: betaGroupIds,
            buildIds: buildIds)
        return APIEndpoint(
            path: "betaTesters",
            method: .post,
            parameters: nil,
            body: try? JSONEncoder().encode(betaTester))
    }
}
