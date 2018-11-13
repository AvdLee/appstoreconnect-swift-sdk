//
//  BetaBuildLocalization.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
struct BetaBuildLocalization: Decodable {

    /// The resource's attributes.
    let attributes: BetaBuildLocalization.Attributes?

    /// (Required) The opaque resource ID that uniquely identifies the resource.
    let `id`: String

    /// Navigational links to related data and included resource types and IDs.
    let relationships: BetaBuildLocalization.Relationships?

    /// (Required) The resource type.Value: betaBuildLocalizations
    let type: String

    /// (Required) Navigational links that include the self-link.
    let links: ResourceLinks

    /// Attributes that describe a resource.
    struct Attributes: Decodable {
    
        /// The specified locale. Refer to Table 1 for possible values.
        let locale: String?
    
        /// A field that describes changes and additions to a build and indicates features you would like your users to test.
        let whatsNew: String?
    }
    
    struct Relationships: Decodable {
    
        /// BetaBuildLocalization.Relationships.Build
        let build: BetaBuildLocalization.Relationships.Build?
    }
}

/// MARK: BetaBuildLocalization.Relationships
extension BetaBuildLocalization.Relationships {
    
    struct Build: Decodable {
    
        /// BetaBuildLocalization.Relationships.Build.Data
        let data: BetaBuildLocalization.Relationships.Build.Data?
    
        /// BetaBuildLocalization.Relationships.Build.Links
        let links: BetaBuildLocalization.Relationships.Build.Links?
    }
}

/// MARK: BetaBuildLocalization.Relationships.Build
extension BetaBuildLocalization.Relationships.Build {
    
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
