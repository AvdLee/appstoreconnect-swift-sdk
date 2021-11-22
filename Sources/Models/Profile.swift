//
//  Profile.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/22/19.
//

import Foundation

/// The data structure that represents the resource.
public struct Profile: Codable {
    
    /// Attributes that describe a resource.
    public struct Attributes: Codable {
        public let name: String?
        public let platform: BundleIdPlatform?
        public let profileContent: String?
        public let uuid: String?
        public let createdDate: Date?
        public let profileState: ProfileState?
        public let profileType: ProfileType?
        public let expirationDate: Date?
    }

    public struct Relationships: Codable {

        /// Profile.Relationships.Certificates
        public let certificates: Profile.Relationships.Certificates?

        /// Profile.Relationships.Devices
        public let devices: Profile.Relationships.Devices?

        /// Profile.Relationships.BundleId
        public let bundleId: Profile.Relationships.BundleId?
    }

    /// The resource's attributes.
    public let attributes: Profile.Attributes?

    /// The opaque resource ID that uniquely identifies the resource.
    public let `id`: String

    /// Navigational links to related data and included resource types and IDs.
    public let relationships: Profile.Relationships?

    /// The resource type.Value: profiles
    public private(set) var type: String = "profiles"

    /// Navigational links that include the self-link.
    public let links: ResourceLinks<ProfileResponse>
}

// MARK: Profile.Relationships
extension Profile.Relationships {

    public struct Certificates: Codable {

        /// [Profile.Relationships.Certificates.Data]
        public let data: [Profile.Relationships.Certificates.Data]?

        /// Profile.Relationships.Certificates.Links
        public let links: Profile.Relationships.Certificates.Links?

        /// PagingInformation
        public let meta: PagingInformation?
    }

    public struct Devices: Codable {

        /// [Profile.Relationships.Devices.Data]
        public let data: [Profile.Relationships.Devices.Data]?

        /// Profile.Relationships.Devices.Links
        public let links: Profile.Relationships.Devices.Links?

        /// PagingInformation
        public let meta: PagingInformation?
    }

    public struct BundleId: Codable {

        /// Profile.Relationships.BundleId.Data
        public let data: Profile.Relationships.BundleId.Data?

        /// Profile.Relationships.BundleId.Links
        public let links: Profile.Relationships.BundleId.Links?
    }
}

// MARK: Profile.Relationships.Certificates
extension Profile.Relationships.Certificates {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: apps
        public private(set) var type: String = "certificates"
    }

    public struct Links: Codable {

        /// uri-reference
        public let related: URL?

        /// uri-reference
        public let `self`: URL?
    }
}

// MARK: Profile.Relationships.Devices
extension Profile.Relationships.Devices {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: betaTesters
        public private(set) var type: String = "devices"
    }

    public struct Links: Codable {

        /// uri-reference
        public let related: URL?

        /// uri-reference
        public let `self`: URL?
    }
}

// MARK: Profile.Relationships.BundleId
extension Profile.Relationships.BundleId {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: bundleIds
        public private(set) var type: String = "bundleIds"
    }

    public struct Links: Codable {

        /// uri-reference
        public let related: URL?

        /// uri-reference
        public let `self`: URL?
    }
}
