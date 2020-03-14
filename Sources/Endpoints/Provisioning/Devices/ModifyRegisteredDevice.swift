//
//  ModifyRegisteredDevice.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/24/19.
//

import Foundation

extension APIEndpoint where T == DeviceResponse {

    /// Modify a capability for a bundle ID.
    public static func modifyRegisteredDevice(
        id: String,
        name: String,
        status: DeviceStatus) -> APIEndpoint {

        let request = DeviceUpdateRequest(
            id: id,
            name: name,
            status: status
        )

        return APIEndpoint(
            path: "devices/\(id)",
            method: .patch,
            parameters: nil,
            body: request.erased)
    }
}
