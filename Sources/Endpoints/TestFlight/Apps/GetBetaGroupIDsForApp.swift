//
//  GetBetaGroupIDsForApp.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint where T == AppBetaGroupsLinkagesResponse {

    /// Get a list of the beta group resource IDs associated with a specific app.
    ///
    /// - Parameters:
    ///   - id: An opaque resource ID that uniquely identifies the resource.
    ///   - limit: Number of resources to return.
    public static func betaGroupIDs(forAppWithId id: String, limit: Int? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }
        return APIEndpoint(
            path: "apps/\(id)/relationships/betaGroups",
            method: .get,
            parameters: parameters)
    }
}
