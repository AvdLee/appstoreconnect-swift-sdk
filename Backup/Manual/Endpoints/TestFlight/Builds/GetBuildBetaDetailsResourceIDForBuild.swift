//
//  GetBuildBetaDetailsResourceIDForBuild.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == BuildBuildBetaDetailLinkageResponse {

    /// Get the build beta details resource ID associated with a specific build.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func buildBetaDetailID(forBuildWithId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "builds/\(id)/relationships/buildBetaDetail",
            method: .get,
            parameters: nil)
    }
}
