//
//  RemoveBundleID.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Rui Costa on 30/12/2019.
//

import Foundation

extension APIEndpoint where T == Void {
    
    public static func remove(bundleWithId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "bundleIds/\(id)",
            method: .delete,
            parameters: nil)
    }
}
