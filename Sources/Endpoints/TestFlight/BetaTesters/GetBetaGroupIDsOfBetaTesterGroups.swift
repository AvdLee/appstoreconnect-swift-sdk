//
//  GetBetaGroupIDsOfBetaTesterGroups.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint where T == BetaTesterBetaGroupsLinkagesResponse {

    /// Get a list of group resource IDs associated with a beta tester.
    ///
    /// - Parameters:
    ///   - id: An opaque resource ID that uniquely identifies the resource.
    ///   - limit: Number of resources to return.
    public static func betaGroupIDs(
        ofBetaTesterWithId id: String,
        limit: Int? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }
        return APIEndpoint(
            path: "betaTesters/\(id)/relationships/betaGroups",
            method: .get,
            parameters: parameters)
    }
}
