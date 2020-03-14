//
//  ModifyCapabilityConfiguration.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/23/19.
//

import Foundation

extension APIEndpoint where T == BundleIdCapabilityResponse {

    /// Update the configuration of a specific capability.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the bundle identifier.
    ///   - capabilityType: (Required) The capability type.
    ///   - settings: (Required) An optional array of settings for this capability.
    public static func modifyCapability(
        id: String,
        capabilityType: CapabilityType,
        settings: [CapabilitySetting]? = nil) -> APIEndpoint {

        let request = BundleIdCapabilityUpdateRequest(
            bundleId: id,
            capabilityType: capabilityType,
            settings: settings
        )

        return APIEndpoint(
            path: "bundleIdCapabilities/\(id)",
            method: .patch,
            parameters: nil,
            body: request.erased)
    }
}
