//
//  GetResourceIDsOfPrereleaseVersionsForBuild.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == BuildPreReleaseVersionLinkageResponse {

    /// Get a list of resource IDs of prerelease versions associated with a build.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func prereleaseVersionIDs(ofForBuildWithId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "builds/\(id)/relationships/preReleaseVersion",
            method: .get,
            parameters: nil)
    }
}
