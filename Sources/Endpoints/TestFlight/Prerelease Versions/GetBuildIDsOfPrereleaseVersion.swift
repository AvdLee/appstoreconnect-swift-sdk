//
//  GetBuildIDsOfPrereleaseVersion.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == PrereleaseVersionBuildsLinkagesResponse {

    /// Get a list of build resource IDs associated with a provided prerelease version.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - limit: Number of resources to return.
    public static func buildIDs(
        ofPrereleaseVersionWithId id: String,
        limit: Int? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }
        return APIEndpoint(
            path: "preReleaseVersions/\(id)/relationships/builds",
            method: .get,
            parameters: parameters)
    }
}
