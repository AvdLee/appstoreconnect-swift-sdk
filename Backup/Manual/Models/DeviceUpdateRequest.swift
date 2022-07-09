//
//  DeviceUpdateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/24/19.
//

import Foundation

/// A request containing a single resource.
public struct DeviceUpdateRequest: Codable {

    public struct Data: Codable {

        /// The resource's attributes.
        public let attributes: DeviceUpdateRequest.Data.Attributes

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: devices
        public private(set) var type: String = "devices"
    }

    /// The object types and IDs of the related resources.
    public let data: DeviceUpdateRequest.Data

    /// - Parameters:
    ///   - id: The opaque resource ID that uniquely identifies the resource.
    ///   - name: The name of the device.
    ///   - status: The status of the device.
    init(id: String,
         name: String,
         status: DeviceStatus) {
        data = .init(
            attributes: .init(
                name: name,
                status: status
            ),
            id: id)
    }
}

// MARK: BundleIdCapabilityCreateRequest.Data
extension DeviceUpdateRequest.Data {

    /// Attributes that describe a resource.
    public struct Attributes: Codable {

        /// The name of the device.
        public let name: String?

        /// The status of the device.
        public let status: DeviceStatus?
    }
}
