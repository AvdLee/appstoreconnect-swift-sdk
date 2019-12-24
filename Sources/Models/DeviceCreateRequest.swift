//
//  DeviceCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/24/19.
//

import Foundation

/// A request containing a single resource.
public struct DeviceCreateRequest: Codable {

    /// - Parameters:
    ///   - name: The opaque resource ID that uniquely identifies the resource.
    ///   - platform:
    ///   - udid:
    init(name: String,
         platform: Platform,
         udid: String) {
        data = .init(
            attributes: .init(
                name: name,
                platform: platform,
                udid: udid
            ))
    }

    /// The resource data.
    public let data: DeviceCreateRequest.Data

    public struct Data: Codable {

        /// The resource's attributes.
        public let attributes: DeviceCreateRequest.Data.Attributes

        /// The resource type.Value: devices
        public let type: String = "devices"
    }
}

/// MARK: DeviceCreateRequest.Data
extension DeviceCreateRequest.Data {

    /// Attributes that describe a resource.
    public struct Attributes: Codable {

        ///
        public let name: String?

        ///
        public let platform: Platform?

        ///
        public let udid: String?
    }
}
