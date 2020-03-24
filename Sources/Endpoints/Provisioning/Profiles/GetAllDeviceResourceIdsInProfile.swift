//
//  GetAllDeviceResourceIdsInProfile.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/24/19.
//

import Foundation

extension APIEndpoint where Request == EmptyBody, Response == ProfileDevicesLinkagesResponse {

    /// Get the resource IDs of all devices associated with a specific provisioning profile.
    public static func getAllDeviceIds(
        inProfileId id: String,
        limit: Int? = nil) -> APIEndpoint {

        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }

        return APIEndpoint(
            path: "profiles/\(id)/relationships/devices",
            method: .get,
            parameters: parameters)
    }
}
