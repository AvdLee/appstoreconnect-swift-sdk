//
//  GetVisibleAppResourceIDsForUser.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//
    

extension APIEndpoint where T == UserVisibleAppsLinkagesResponse {

    /// Get a list of app resource IDs to which a user on your team has access.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    
    ///   - limit: Number of resources to return.
    public static func appIDs(
        visibleForUserWithId id: String,
        limit: Int? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }
        return APIEndpoint(
            path: "users/\(id)/relationships/visibleApps",
            method: .get,
            parameters: parameters)
    }
}
