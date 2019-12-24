//
//  BundleIdCapabilityCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/23/19.
//

import Foundation

/// A request containing a single resource.
public struct BundleIdCapabilityCreateRequest: Codable {

    /// - Parameters:
    ///   - bundleId: The opaque resource ID that uniquely identifies the resource.
    ///   - capabilityType:
    ///   - settings:
    init(bundleId: String,
         capabilityType: CapabilityType,
         settings: [CapabilitySetting]? = nil) {
        data = .init(
            attributes: .init(
                capabilityType: capabilityType,
                settings: settings
            ),
            relationships: .init(
                bundleId: .init(data: .init(id: bundleId))))
    }

    /// The resource data.
    public let data: BundleIdCapabilityCreateRequest.Data

    public struct Data: Codable {

        /// The resource's attributes.
        public let attributes: BundleIdCapabilityCreateRequest.Data.Attributes

        /// The types and IDs of the related data to update.
        public let relationships: BundleIdCapabilityCreateRequest.Data.Relationships

        /// The resource type.Value: bundleIdCapabilities
        public let type: String = "bundleIdCapabilities"
    }
}

/// MARK: BundleIdCapabilityCreateRequest.Data
extension BundleIdCapabilityCreateRequest.Data {

    /// Attributes that describe a resource.
    public struct Attributes: Codable {

        /// The type of the capabillity.
        public let capabilityType: CapabilityType?

        /// Specific settings for this capability.
        public let settings: [CapabilitySetting]?
    }

    public struct Relationships: Codable {

        /// BundleIdCapabilityCreateRequest.Data.Relationships.BundleId (Required)
        public let bundleId: BundleIdCapabilityCreateRequest.Data.Relationships.BundleId
    }
}

/// MARK: BundleIdCapabilityCreateRequest.Data.Relationships
extension BundleIdCapabilityCreateRequest.Data.Relationships {

    public struct BundleId: Codable {

        /// BundleIdCapabilityCreateRequest.Data.Relationships.BundleId.Data (Required)
        public let data: BundleIdCapabilityCreateRequest.Data.Relationships.BundleId.Data
    }
}

/// MARK: BundleIdCapabilityCreateRequest.Data.Relationships.BundleId
extension BundleIdCapabilityCreateRequest.Data.Relationships.BundleId {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: apps
        public let type: String = "bundleIds"
    }
}
