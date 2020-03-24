//
//  GetAppResourceIDForBuild.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where Request == EmptyBody, Response == BuildAppLinkageResponse {

    /// Get the app resource ID associated with a specific build.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func appID(forBuildWithId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "builds/\(id)/relationships/app",
            method: .get,
            parameters: nil)
    }
}
