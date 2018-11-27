//
//  GetPrereleaseVersionIDsForApp.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint {

    /// Get a list of prerelease version IDs for a specific app.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - limit: Number of resources to return.
    public static func prereleaseVersionIDsForApp(withId id: String, limit: Int? = nil) -> APIEndpoint<AppPreReleaseVersionsLinkagesResponse> {
        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }
        return APIEndpoint<AppPreReleaseVersionsLinkagesResponse>(
            path: "apps/\(id)/relationships/preReleaseVersions",
            method: .get,
            parameters: parameters)
    }
}
