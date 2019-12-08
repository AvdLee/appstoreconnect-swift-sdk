//
//  RegisterNewBundleID.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Rui Costa on 07/12/2019.
//

import Foundation

extension APIEndpoint where T == BundleIdResponse {
    
    /// Register a new bundle ID for app development.
    public static func registerNewBundleId(
        identifier: String,
        name: String,
        platform: BundleIdPlatform) -> APIEndpoint {
        
        let request = BundleIdCreateRequest(data: .init(
            attributes: .init(
            identifier: identifier,
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
