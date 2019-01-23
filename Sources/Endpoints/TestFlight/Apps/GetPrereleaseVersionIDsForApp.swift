//
//  GetPrereleaseVersionIDsForApp.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    

extension APIEndpoint where T == AppPreReleaseVersionsLinkagesResponse {

    /// Get a list of prerelease version IDs for a specific app.
    ///
    /// - Parameters:
    ///   - id: An opaque resource ID that uniquely identifies the resource.
    ///   - limit: Number of resources to return.
    public static func prereleaseVersionIDs(forAppWithId id: String, limit: Int? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }
        return APIEndpoint(
            path: "apps/\(id)/relationships/preReleaseVersions",
            method: .get,
            parameters: parameters)
    }
}
