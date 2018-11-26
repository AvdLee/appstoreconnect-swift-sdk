//
//  GetBetaGroupIDsForApp.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint {

    /// Get a list of the beta group resource IDs associated with a specific app.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - limit: Number of resources to return.
    public static func getBetaGroupIDsForApp(withId id: String, limit: Int? = nil) -> APIEndpoint<AppBetaGroupsLinkagesResponse> {
        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }
        return APIEndpoint<AppBetaGroupsLinkagesResponse>(
            path: "apps/\(id)/relationships/betaGroups",
            method: .get,
            parameters: parameters)
    }
}
