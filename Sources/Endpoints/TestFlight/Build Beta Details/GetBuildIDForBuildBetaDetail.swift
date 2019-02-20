//
//  GetBuildIDForBuildBetaDetail.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == BuildBetaDetailBuildLinkageResponse {

    /// Get the build resource ID for a specific build beta detail.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func buildID(forBuildBetaDetailWithId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "buildBetaDetails/\(id)/relationships/build",
            method: .get,
            parameters: nil)
    }
}
