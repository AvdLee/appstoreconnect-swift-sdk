//
//  GetBundleResourceIdInProfile.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/24/19.
//

import Foundation

extension APIEndpoint where T == ProfileBundleIdLinkageResponse {

    /// Get the bundle ID information for a specific provisioning profile.
    public static func getBundleResourceId(
        inProfileId id: String) -> APIEndpoint {

        return APIEndpoint(
            path: "profiles/\(id)/relationships/bundleId",
            method: .get,
            parameters: nil)
    }
}
