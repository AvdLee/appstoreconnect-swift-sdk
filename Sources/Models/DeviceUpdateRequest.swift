//
//  DeviceUpdateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/24/19.
//

import Foundation

/// A request containing a single resource.
public struct DeviceUpdateRequest: Codable {

    /// - Parameters:
    ///   - id: The opaque resource ID that uniquely identifies the resource.
    ///   - name:
    ///   - status:
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

    /// The object types and IDs of the related resources.
    public let data: DeviceUpdateRequest.Data

    public struct Data: Codable {

        /// The resource's attributes.
        public let attributes: DeviceUpdateRequest.Data.Attributes

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: devices
        public let type: String = "devices"
    }
}

/// MARK: BundleIdCapabilityCreateRequest.Data
extension DeviceUpdateRequest.Data {

    /// Attributes that describe a resource.
    public struct Attributes: Codable {

        ///
        public let name: String?

        ///
        public let status: DeviceStatus?
    }
}
