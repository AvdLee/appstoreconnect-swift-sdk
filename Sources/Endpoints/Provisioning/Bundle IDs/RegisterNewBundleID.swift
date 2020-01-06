//
//  RegisterNewBundleID.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Rui Costa on 07/12/2019.
//

import Foundation

extension APIEndpoint where T == BundleIdResponse {
    
    /// Register a new bundle ID for app development.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the bundle identifier.
    ///   - name: (Required) The new name for the bundle identifier.
    ///   - platform: (Required) The platform of the bundle identifier.
    public static func registerNewBundleId(
        id: String,
        name: String,
        platform: BundleIdPlatform) -> APIEndpoint {
        
        let request = BundleIdCreateRequest(data: .init(
            attributes: .init(
                identifier: id,
                name: name,
                platform: platform,
                seedId: nil)))
        
        return APIEndpoint(
            path: "bundleIds",
            method: .post,
            parameters: nil,
            body: try? JSONEncoder().encode(request))
    }
}
