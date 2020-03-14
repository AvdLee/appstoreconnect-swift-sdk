//
//  ProfileCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/24/19.
//

import Foundation

/// A request containing a single resource.
public struct ProfileCreateRequest: Codable {

    public struct Data: Codable {

        /// The resource's attributes.
        public let attributes: ProfileCreateRequest.Data.Attributes

        /// The types and IDs of the related data to update.
        public let relationships: ProfileCreateRequest.Data.Relationships

        /// The resource type.Value: profiles
        public let type: String = "profiles"
    }

    /// The resource data.
    public let data: ProfileCreateRequest.Data

    /// - Parameters:
    ///   - id: The opaque resource ID that uniquely identifies the resource.
    ///   - name:
    ///   - profileType:
    init(id: String,
         name: String,
         profileType: ProfileType,
         certificateIds: [String] = [],
         deviceIds: [String] = []) {

        data = .init(
            attributes: .init(
                name: name,
                profileType: profileType
            ),
            relationships: .init(
                bundleId: .init(data: .init(id: id)),
                certificates: .init(data: certificateIds.map { .init(id: $0) }),
                devices: .init(data: deviceIds.map { .init(id: $0) })
            )
        )
    }
}

// MARK: ProfileCreateRequest.Data
extension ProfileCreateRequest.Data {

    /// Attributes that describe a resource.
    public struct Attributes: Codable {

        /// The name of the profile.
        public let name: String?

        /// The type of the profile.
        public let profileType: ProfileType?
    }

    public struct Relationships: Codable {

        /// ProfileCreateRequest.Data.Relationships.BundleId (Required)
        public let bundleId: ProfileCreateRequest.Data.Relationships.BundleId

        /// ProfileCreateRequest.Data.Relationships.Certificates (Required)
        public let certificates: ProfileCreateRequest.Data.Relationships.Certificates

        /// ProfileCreateRequest.Data.Relationships.Devices
        public let devices: ProfileCreateRequest.Data.Relationships.Devices
    }
}

// MARK: ProfileCreateRequest.Data.Relationships
extension ProfileCreateRequest.Data.Relationships {

    public struct BundleId: Codable {

        /// ProfileCreateRequest.Data.Relationships.BundleId.Data (Required)
        public let data: ProfileCreateRequest.Data.Relationships.BundleId.Data
    }

    public struct Certificates: Codable {

        /// ProfileCreateRequest.Data.Relationships.Certificates.Data (Required)
        public let data: [ProfileCreateRequest.Data.Relationships.Certificates.Data]
    }

    public struct Devices: Codable {

        /// ProfileCreateRequest.Data.Relationships.Devices.Data (Required)
        public let data: [ProfileCreateRequest.Data.Relationships.Devices.Data]
    }
}

// MARK: ProfileCreateRequest.Data.Relationships.BundleId
extension ProfileCreateRequest.Data.Relationships.BundleId {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: apps
        public let type: String = "bundleIds"
    }
}

// MARK: ProfileCreateRequest.Data.Relationships.Certificates
extension ProfileCreateRequest.Data.Relationships.Certificates {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: apps
        public let type: String = "certificates"
    }
}

// MARK: ProfileCreateRequest.Data.Relationships.Devices
extension ProfileCreateRequest.Data.Relationships.Devices {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: apps
        public let type: String = "devices"
    }
}
