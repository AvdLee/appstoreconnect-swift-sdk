//
//  PrereleaseVersion.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation

/// The data structure that represents the resource.
public struct PrereleaseVersion: Codable {

    /// Attributes that describe a resource.
    public struct Attributes: Codable {

        /// The platform of the prerelease version of your app.
        public let platform: Platform?

        /// The version number of the prerelease version of your app.
        public let version: String?
    }

    public struct Relationships: Codable {

        /// PrereleaseVersion.Relationships.App
        public let app: PrereleaseVersion.Relationships.App?

        /// PrereleaseVersion.Relationships.Builds
        public let builds: PrereleaseVersion.Relationships.Builds?
    }

    /// The resource's attributes.
    public let attributes: PrereleaseVersion.Attributes?

    /// The opaque resource ID that uniquely identifies the resource.
    public let `id`: String

    /// Navigational links that include the self-link.
    public let links: ResourceLinks<PrereleaseVersionResponse>

    /// Navigational links to related data and included resource types and IDs.
    public let relationships: PrereleaseVersion.Relationships?

    /// The resource type.Value: preReleaseVersions
    public private(set) var type: String = "preReleaseVersions"
}

// MARK: PrereleaseVersion.Relationships
extension PrereleaseVersion.Relationships {

    public struct App: Codable {

        /// PrereleaseVersion.Relationships.App.Data
        public let data: PrereleaseVersion.Relationships.App.Data?

        /// PrereleaseVersion.Relationships.App.Links
        public let links: PrereleaseVersion.Relationships.App.Links?
    }

    public struct Builds: Codable {

        /// [PrereleaseVersion.Relationships.Builds.Data]
        public let data: [PrereleaseVersion.Relationships.Builds.Data]?

        /// PrereleaseVersion.Relationships.Builds.Links
        public let links: PrereleaseVersion.Relationships.Builds.Links?

        /// PagingInformation
        public let meta: PagingInformation?
    }
}

// MARK: PrereleaseVersion.Relationships.App
extension PrereleaseVersion.Relationships.App {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: apps
        public private(set) var type: String = "apps"
    }

    public struct Links: Codable {

        /// uri-reference
        public let related: URL?

        /// uri-reference
        public let `self`: URL?
    }
}

// MARK: PrereleaseVersion.Relationships.Builds
extension PrereleaseVersion.Relationships.Builds {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: builds
        public private(set) var type: String = "builds"
    }

    public struct Links: Codable {

        /// uri-reference
        public let related: URL?

        /// uri-reference
        public let `self`: URL?
    }
}
