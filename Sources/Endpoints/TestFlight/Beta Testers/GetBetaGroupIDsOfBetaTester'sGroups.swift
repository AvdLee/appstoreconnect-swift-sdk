//
//  GetBetaGroupIDsOfBetaTester'sGroups.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint {

    /// Get a list of group resource IDs associated with a beta tester.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - limit: Number of resources to return.
    public static func getBetaGroupIDsOfBetaTester(
        withId id: String,
        limit: Int? = nil) -> APIEndpoint<BetaTesterBetaGroupsLinkagesResponse> {
        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }
        return APIEndpoint<BetaTesterBetaGroupsLinkagesResponse>(
            path: "betaTesters/\(id)/relationships/betaGroups",
            method: .get,
            parameters: parameters)
    }
}
