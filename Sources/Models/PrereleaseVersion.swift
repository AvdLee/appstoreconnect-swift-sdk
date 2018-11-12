//
//  PrereleaseVersion.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
struct PrereleaseVersion: Decodable {

    /// The resource's attributes.
    let attributes: PrereleaseVersion.Attributes?

    /// (Required) The opaque resource ID that uniquely identifies the resource.
    let `id`: String

    /// (Required) Navigational links that include the self-link.
    let links: ResourceLinks

    /// Navigational links to related data and included resource types and IDs.
    let relationships: PrereleaseVersion.Relationships?

    /// (Required) The resource type.Value: preReleaseVersions
    let type: String

    /// Attributes that describe a resource.
    struct Attributes: Decodable {
    
        /// The platform of the prerelease version of your app.
        let platform: Platform?
    
        /// The version number of the prerelease version of your app.
        let version: String?
    }
    
    struct Relationships: Decodable {
    
        /// PrereleaseVersion.Relationships.App
        let app: PrereleaseVersion.Relationships.App?
    
        /// PrereleaseVersion.Relationships.Builds
        let builds: PrereleaseVersion.Relationships.Builds?
    }
}

extension PrereleaseVersion.Relationships {
    
    struct App: Decodable {
    
        /// PrereleaseVersion.Relationships.App.Data
        let data: PrereleaseVersion.Relationships.App.Data?
    
        /// PrereleaseVersion.Relationships.App.Links
        let links: PrereleaseVersion.Relationships.App.Links?
    }

    struct Builds: Decodable {
    
        /// [PrereleaseVersion.Relationships.Builds.Data]
        let data: [PrereleaseVersion.Relationships.Builds.Data]?
    
        /// PrereleaseVersion.Relationships.Builds.Links
        let links: PrereleaseVersion.Relationships.Builds.Links?
    
        /// PagingInformation
        let meta: PagingInformation?
    }
}

extension PrereleaseVersion.Relationships.App {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: apps
        let type: String
    }
    
    struct Links: Decodable {
    
        /// uri-reference
        let related: URL?
    
        /// uri-reference
        let `self`: URL?
    }
}

extension PrereleaseVersion.Relationships.Builds {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: builds
        let type: String
    }
    
    struct Links: Decodable {
    
        /// uri-reference
        let related: URL?
    
        /// uri-reference
        let `self`: URL?
    }
}
