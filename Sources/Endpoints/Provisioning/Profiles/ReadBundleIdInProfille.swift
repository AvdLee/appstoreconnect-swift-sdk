//
//  ReadBundleIdInProfille.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/24/19.
//

import Foundation

extension APIEndpoint where Request == EmptyBody, Response == BundleIdResponse {

    /// Get the bundle ID information for a specific provisioning profile.
    public static func readBundleId(
        inProfileId id: String,
        fields: [Profiles.Field]? = nil) -> APIEndpoint {

        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }

        return APIEndpoint(
            path: "profiles/\(id)/bundleId",
            method: .get,
            parameters: parameters)
    }
}
