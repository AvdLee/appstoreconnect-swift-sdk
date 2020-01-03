//
//  BundleId.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/22/19.
//

import Foundation

/// The data structure that represents the resource.
public struct BundleId: Codable {

    /// Attributes that describe a resource.
    public struct Attributes: Codable {

        /// The unique identifier of the bundle id.
        public let identifier: String?

        /// The name for the bundle id.
        public let name: String?

        /// The platform for the bundle id.
        public let platform: BundleIdPlatform?

        /// A seed id for the bundle id.
        public let seedId: String?
    }

    public struct Relationships: Codable {

        /// BundleId.Relationships.Profiles
        public let profiles: BundleId.Relationships.Profiles?

        /// BundleId.Relationships.BundleIdCapabilities
        public let bundleIdCapabilities: BundleId.Relationships.BundleIdCapabilities?
    }

    /// The resource's attributes.
    public let attributes: BundleId.Attributes?

    /// The opaque resource ID that uniquely identifies the resource.
    public let `id`: String

    /// Navigational links to related data and included resource types and IDs.
    public let relationships: BundleId.Relationships?

    /// The resource type.Value: bundleIds
    public let type: String = "bundleIds"

    /// Navigational links that include the self-link.
    public let links: ResourceLinks<BundleIdResponse>
}

// MARK: BundleId.Relationships
extension BundleId.Relationships {

    public struct Profiles: Codable {

        /// [BundleId.Relationships.Profiles.Data]
        public let data: [BundleId.Relationships.Profiles.Data]?

        /// BundleId.Relationships.Profiles.Links
        public let links: BundleId.Relationships.Profiles.Links?

        /// PagingInformation
        public let meta: PagingInformation?
    }

    public struct BundleIdCapabilities: Codable {

        /// [BundleId.Relationships.BundleIdCapabilities.Data]
        public let data: [BundleId.Relationships.BundleIdCapabilities.Data]?

        /// BundleId.Relationships.BundleIdCapabilities.Links
        public let links: BundleId.Relationships.BundleIdCapabilities.Links?

        /// PagingInformation
        public let meta: PagingInformation?
    }
}

// MARK: BundleId.Relationships.Profiles
extension BundleId.Relationships.Profiles {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: profiles
        public let type: String = "profiles"
    }

    public struct Links: Codable {

        /// uri-reference
        public let related: URL?

        /// uri-reference
        public let `self`: URL?
    }
}

// MARK: BundleId.Relationships.BundleIdCapabilities
extension BundleId.Relationships.BundleIdCapabilities {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: profiles
        public let type: String = "bundleIdCapabilities"
    }

    public struct Links: Codable {

        /// uri-reference
        public let related: URL?

        /// uri-reference
        public let `self`: URL?
    }
}
