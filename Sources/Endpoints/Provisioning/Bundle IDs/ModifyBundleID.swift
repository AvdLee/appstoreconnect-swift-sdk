//
//  ModifyBundleID.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Rui Costa on 30/12/2019.
//

import Foundation

extension APIEndpoint where T == BundleIdResponse {
    
    /// Update a specific bundle ID’s name
    public static func modify(
        bundleWithId id: String,
        name: String) -> APIEndpoint {
        
        let request = BundleIdUpdateRequest(data: .init(
            id: id,
            attributes: .init(name: name)))
        
        return APIEndpoint(
            path: "bundleIds",
            method: .patch,
            parameters: nil,
            body: try? JSONEncoder().encode(request))
    }
}
