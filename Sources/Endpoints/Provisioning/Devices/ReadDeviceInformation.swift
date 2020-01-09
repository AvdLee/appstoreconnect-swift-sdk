//
//  ReadDeviceInformation.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/24/19.
//

import Foundation

extension APIEndpoint where T == DeviceResponse {

    /// Get information about a specific bundle ID.
    public static func readDeviceInformation(
        id: String,
        fields: [Devices.Field]? = nil) -> APIEndpoint {

        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }

        return APIEndpoint(
            path: "devices/\(id)",
            method: .get,
            parameters: parameters)
    }
}
