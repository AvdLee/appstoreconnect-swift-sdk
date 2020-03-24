//
//  GetAppResourceIDForPrereleaseVersion.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where Request == EmptyBody, Response == PrereleaseVersionAppLinkageResponse {

    /// Get the app resource ID associated with a specific prerelease version.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func appID(forPrereleaseVersionWithId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "preReleaseVersions/\(id)/relationships/app",
            method: .get,
            parameters: nil)
    }
}
