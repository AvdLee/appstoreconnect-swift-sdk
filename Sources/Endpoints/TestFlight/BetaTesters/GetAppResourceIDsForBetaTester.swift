//
//  GetAppResourceIDsForBetaTester.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//

extension APIEndpoint where Request == EmptyBody, Response == BetaTesterAppsLinkagesResponse {

    /// Get a list of app resource IDs associated with a beta tester.
    ///
    /// - Parameters:
    ///   - id: An opaque resource ID that uniquely identifies the resource.
    ///   - limit: Number of resources to return.
    public static func appIDs(
        forBetaTesterWithId id: String,
        limit: Int? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }
        return APIEndpoint(
            path: "betaTesters/\(id)/relationships/apps",
            method: .get,
            parameters: parameters)
    }
}
