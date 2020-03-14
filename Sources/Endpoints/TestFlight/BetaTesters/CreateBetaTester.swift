//
//  CreateBetaTester.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//

import Foundation

extension APIEndpoint where T == BetaTesterResponse {

    /// Create a beta tester assigned to a group, a build, or an app.
    ///
    /// - Parameters:
    ///   - email: The beta tester's email address, used for sending beta testing invitations.
    ///   - firstName: The beta tester's first name.
    ///   - lastName: The beta tester's last name.
    ///   - betaGroupIds: Array of opaque resource ID that uniquely identifies the resources.
    ///
    /// - Attention: Non empty betaGroupIds is required when creating betaTesters.
    public static func create(
        betaTesterWithEmail email: String,
        firstName: String? = nil,
        lastName: String? = nil,
        betaGroupIds: [String]) -> APIEndpoint {
        let betaTester = BetaTesterCreateRequest(
            email: email,
            firstName: firstName,
            lastName: lastName,
            betaGroupIds: betaGroupIds,
            buildIds: nil)
        return APIEndpoint(
            path: "betaTesters",
            method: .post,
            parameters: nil,
            body: betaTester.erased)
    }
    
    /// Create a beta tester assigned to a group, a build, or an app.
    ///
    /// - Parameters:
    ///   - email: The beta tester's email address, used for sending beta testing invitations.
    ///   - firstName: The beta tester's first name.
    ///   - lastName: The beta tester's last name.
    ///   - buildIds: Array of opaque resource ID that uniquely identifies the resources.
    ///
    /// - Attention: Non empty buildIds is required when creating betaTesters.
    public static func create(
        betaTesterWithEmail email: String,
        firstName: String? = nil,
        lastName: String? = nil,
        buildIds: [String]) -> APIEndpoint {
        let betaTester = BetaTesterCreateRequest(
            email: email,
            firstName: firstName,
            lastName: lastName,
            betaGroupIds: nil,
            buildIds: buildIds)
        return APIEndpoint(
            path: "betaTesters",
            method: .post,
            parameters: nil,
            body: betaTester.erased)
    }
}
