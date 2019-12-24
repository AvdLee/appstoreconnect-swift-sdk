//
//  BundleIdCapability.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/22/19.
//

import Foundation

/// The data structure that represents the resource.
public struct BundleIdCapability: Codable {

    /// The resource's attributes.
    public let attributes: BundleIdCapability.Attributes?

    /// The opaque resource ID that uniquely identifies the resource.
    public let `id`: String

    /// Navigational links to related data and included resource types and IDs.
    public let relationships: BundleIdCapability.Relationships?

    /// The resource type.Value: profiles
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

        /// BundleIdCapability.Relationships.BundleId
        public let bundleId: BundleIdCapability.Relationships.BundleId?
    }
}

/// MARK: BundleIdCapability.Relationships
extension BundleIdCapability.Relationships {

    public struct BundleId: Codable {

        /// Certificates.Relationships.Certificates.Data
        public let data: BundleIdCapability.Relationships.BundleId.Data?

        /// Certificates.Relationships.Certificates.Links
        public let links: BundleIdCapability.Relationships.BundleId.Links?
    }
}

/// MARK: BundleIdCapability.Relationships.BundleId
extension BundleIdCapability.Relationships.BundleId {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: apps
        public let type: String = "bundleIds"
    }

    public struct Links: Codable {

        /// uri-reference
        public let related: URL?

        /// uri-reference
        public let `self`: URL?
    }
}
