//
//  GetBuildBundleFileSize.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Billy on 11/12/21.
//

import Foundation

extension APIEndpoint where T == BuildBundleFileSizesResponse {

    /// Get all file sizes for a specific build bundle.
    ///
    /// - Parameters:
    ///   - id: An opaque resource ID that uniquely identifies the resource.
    public static func buildBundleFileSizes(
        ofBundleWithId id: String) -> APIEndpoint {
        return APIEndpoint(path: "buildBundles/\(id)/buildBundleFileSizes", method: .get)
    }
}
