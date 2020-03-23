//
//  Device.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/24/19.
//

import Foundation

/// The data structure that represents the resource.
public struct Device: Codable {

    /// Attributes that describe a certificate.
    public struct Attributes: Codable {
        public let deviceClass: DeviceClass?
        public let model: String?
        public let name: String?
        public let platform: BundleIdPlatform?
        public let status: DeviceStatus?
        public let udid: String?
        public let addedDate: Date?
    }

    /// The resource's attributes.
    public let attributes: Device.Attributes

    /// The opaque resource ID that uniquely identifies the resource.
    public let id: String

    /// The resource type.
    public let type: String = "devices"

    /// Navigational links that include the self-link.
    public let links: ResourceLinks<Device>
}
