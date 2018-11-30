//
//  BetaBuildLocalization.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
public struct BetaBuildLocalization: Codable {

    /// The resource's attributes.
    public let attributes: BetaBuildLocalization.Attributes?

    /// The opaque resource ID that uniquely identifies the resource.
    public let `id`: String

    /// Navigational links to related data and included resource types and IDs.
    public let relationships: BetaBuildLocalization.Relationships?

    /// The resource type.Value: betaBuildLocalizations
    public let type: String = "betaBuildLocalizations"

    /// Navigational links that include the self-link.
    public let links: ResourceLinks<BetaBuildLocalizationResponse>

    /// Attributes that describe a resource.
    public struct Attributes: Codable {
    
        /// The specified locale. Refer to Table 1 for possible values.
        public let locale: String?
    
        /// A field that describes changes and additions to a build and indicates features you would like your users to test.
        public let whatsNew: String?
    }
    
    public struct Relationships: Codable {
    
        /// BetaBuildLocalization.Relationships.Build
        public let build: BetaBuildLocalization.Relationships.Build?
    }
}

/// MARK: BetaBuildLocalization.Relationships
extension BetaBuildLocalization.Relationships {
    
    public struct Build: Codable {
    
        /// BetaBuildLocalization.Relationships.Build.Data
        public let data: BetaBuildLocalization.Relationships.Build.Data?
    
        /// BetaBuildLocalization.Relationships.Build.Links
        public let links: BetaBuildLocalization.Relationships.Build.Links?
    }
}

/// MARK: BetaBuildLocalization.Relationships.Build
extension BetaBuildLocalization.Relationships.Build {
    
    public struct Data: Codable {
    
        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// The resource type.Value: builds
        public let type: String = "builds"
    }
    
    public struct Links: Codable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}
