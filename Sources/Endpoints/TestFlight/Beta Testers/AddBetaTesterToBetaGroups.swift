//
//  AddBetaTesterToBetaGroups.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint {

    /// Add one or more beta testers to a specific beta group.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func add(
        betaTester: BetaTesterBetaGroupsLinkagesRequest,
        toBetaGroupWithId id: String) -> APIEndpoint<ErrorResponse> {
        return APIEndpoint<ErrorResponse>(
            path: "betaTesters/\(id)/relationships/betaGroups",
            method: .post,
            parameters: nil)
    }
}
