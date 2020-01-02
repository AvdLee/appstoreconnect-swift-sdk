//
//  BundleIdCapabilityUpdateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/23/19.
//

import Foundation

/// A request containing a single resource.
public struct BundleIdCapabilityUpdateRequest: Codable {

    /// - Parameters:
    ///   - bundleId: The opaque resource ID that uniquely identifies the resource.
    ///   - capabilityType: The capability type.
    ///   - settings: An optional array of settings for this capability.
    init(bundleId: String,
         capabilityType: CapabilityType,
         settings: [CapabilitySetting]? = nil) {
        data = .init(
            attributes: .init(
                capabilityType: capabilityType,
                settings: settings
            ),
            id: bundleId)
    }

    /// The object types and IDs of the related resources.
    public let data: BundleIdCapabilityUpdateRequest.Data

    public struct Data: Codable {

        /// The resource's attributes.
        public let attributes: BundleIdCapabilityUpdateRequest.Data.Attributes

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: bundleIdCapabilities
        public let type: String = "bundleIdCapabilities"
    }
}

// MARK: BundleIdCapabilityCreateRequest.Data
extension BundleIdCapabilityUpdateRequest.Data {

    /// Attributes that describe a resource.
    public struct Attributes: Codable {

        /// The type of the capabillity.
        public let capabilityType: CapabilityType?

        /// Specific settings for this capability.
        public let settings: [CapabilitySetting]?
    }
}
