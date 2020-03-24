//
//  ListAllDevicesInProfile.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/24/19.
//

import Foundation

extension APIEndpoint where Request == EmptyBody, Response == DevicesResponse {

    /// Get a list of all devices for a specific provisioning profile.
    public static func listAllDevices(
        inProfileId id: String,
        fields: [Profiles.Field]? = nil,
        limit: Int? = nil) -> APIEndpoint {

        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let limit = limit { parameters["limit"] = limit }

        return APIEndpoint(
            path: "profiles/\(id)/devices",
            method: .get,
            parameters: parameters)
    }
}
