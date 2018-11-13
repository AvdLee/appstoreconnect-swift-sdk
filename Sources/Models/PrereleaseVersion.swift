//
//  PrereleaseVersion.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
public struct PrereleaseVersion: Decodable {

    /// The resource's attributes.
    public let attributes: PrereleaseVersion.Attributes?

    /// (Required) The opaque resource ID that uniquely identifies the resource.
    public let `id`: String

    /// (Required) Navigational links that include the self-link.
    public let links: ResourceLinks

    /// Navigational links to related data and included resource types and IDs.
    public let relationships: PrereleaseVersion.Relationships?

    /// (Required) The resource type.Value: preReleaseVersions
    public let type: String

    /// Attributes that describe a resource.
    public struct Attributes: Decodable {
    
        /// The platform of the prerelease version of your app.
        public let platform: Platform?
    
        /// The version number of the prerelease version of your app.
        public let version: String?
    }
    
    public struct Relationships: Decodable {
    
        /// PrereleaseVersion.Relationships.App
        public let app: PrereleaseVersion.Relationships.App?
    
        /// PrereleaseVersion.Relationships.Builds
        public let builds: PrereleaseVersion.Relationships.Builds?
    }
}

/// MARK: PrereleaseVersion.Relationships
extension PrereleaseVersion.Relationships {
    
    public struct App: Decodable {
    
        /// PrereleaseVersion.Relationships.App.Data
        public let data: PrereleaseVersion.Relationships.App.Data?
    
        /// PrereleaseVersion.Relationships.App.Links
        public let links: PrereleaseVersion.Relationships.App.Links?
    }

    public struct Builds: Decodable {
    
        /// [PrereleaseVersion.Relationships.Builds.Data]
        public let data: [PrereleaseVersion.Relationships.Builds.Data]?
    
        /// PrereleaseVersion.Relationships.Builds.Links
        public let links: PrereleaseVersion.Relationships.Builds.Links?
    
        /// PagingInformation
        public let meta: PagingInformation?
    }
}

/// MARK: PrereleaseVersion.Relationships.App
extension PrereleaseVersion.Relationships.App {
    
    public struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: apps
        public let type: String
    }
    
    public struct Links: Decodable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}

/// MARK: PrereleaseVersion.Relationships.Builds
extension PrereleaseVersion.Relationships.Builds {
    
    public struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: builds
        public let type: String
    }
    
    public struct Links: Decodable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}
