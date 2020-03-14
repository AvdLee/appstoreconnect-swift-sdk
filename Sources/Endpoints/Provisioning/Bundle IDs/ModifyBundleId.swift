//
//  ModifyBundleID.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/22/19.
//

import Foundation

extension APIEndpoint where T == BundleIdResponse {

    /// Update a specific bundle ID’s name.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the bundle identifier.
    ///   - name: (Required) The new name for the bundle identifier.
    public static func modifyBundleId(
        id: String,
        name: String) -> APIEndpoint {

        let request = BundleIdUpdateRequest(id: id, name: name)

        return APIEndpoint(
            path: "bundleIds/\(id)",
            method: .patch,
            parameters: nil,
            body: request.erased)
    }
}
