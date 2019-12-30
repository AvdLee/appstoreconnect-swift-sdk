//
//  RemoveBundleID.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Rui Costa on 30/12/2019.
//

import Foundation

extension APIEndpoint where T == Void {
    
    /// Delete a bundle ID that is used for app development.
    public static func remove(bundleIdWithId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "bundleIds/\(id)",
            method: .delete,
            parameters: nil)
    }
}
