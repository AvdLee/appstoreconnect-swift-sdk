//
//  BundleIdCapabilityResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/22/19.
//

import Foundation

/// The data structure that represents the resource.
public struct BundleIdCapabilityResponse: Codable {

    /// The resource's attributes.
    public let attributes: BundleIdCapabilityResponse.Attributes?

    /// Navigational links to related data and included resource types and IDs.
    public let relationships: BundleIdCapabilityResponse.Relationships?

    /// The resource type.Value: bundleIdCapabilities
    public let type: String = "bundleIdCapabilities"

    /// Navigational links that include the self-link.
    public let links: ResourceLinks<BundleIdCapabilityResponse>

    /// Attributes that describe a resource.
    public struct Attributes: Codable {

        /// The type of the capabillity.
        public let capabilityType: CapabilityType?

        /// Specific settings for this capability.
        public let settings: [CapabilitySetting]?
    }

    public struct Relationships: Codable {

        /// BundleIdCapabilityResponse.Relationships.BundleId
        public let bundleId: BundleIdCapabilityResponse.Relationships.BundleId?
    }
}

// MARK: BundleIdCapabilityResponse.Relationships
extension BundleIdCapabilityResponse.Relationships {

    public struct BundleId: Codable {

        /// BundleIdCapabilityResponse.Relationships.BundleId.Data
        public let data: BundleIdCapabilityResponse.Relationships.BundleId.Data?

        /// BundleIdCapabilityResponse.Relationships.BundleId.Links
        public let links: BundleIdCapabilityResponse.Relationships.BundleId.Links?
    }
}

// MARK: BundleIdCapabilityResponse.Relationships.BundleId
extension BundleIdCapabilityResponse.Relationships.BundleId {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: bundleIds
        public let type: String = "bundleIds"
    }

    public struct Links: Codable {

        /// uri-reference
        public let related: URL?

        /// uri-reference
        public let `self`: URL?
    }
}
