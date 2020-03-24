//
//  RegisterNewDevice.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/24/19.
//

import Foundation

extension APIEndpoint where Request == DeviceCreateRequest, Response == DeviceResponse {

    /// Register a new device for app development.
    public static func registerNewDevice(
        name: String,
        platform: Platform,
        udid: String) -> APIEndpoint {

        let request = DeviceCreateRequest(
            name: name,
            platform: platform,
            udid: udid
        )

        return APIEndpoint(
            path: "devices",
            method: .post,
            parameters: nil,
            body: request)
    }
}
