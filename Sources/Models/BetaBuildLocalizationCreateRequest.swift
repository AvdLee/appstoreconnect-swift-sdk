//
//  BetaBuildLocalizationCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
public struct BetaBuildLocalizationCreateRequest: Codable {

    /// (Required) The resource data.
    public let data: BetaBuildLocalizationCreateRequest.Data
    
    public struct Data: Codable {
    
        /// (Required) The resource's attributes.
        public let attributes: BetaBuildLocalizationCreateRequest.Data.Attributes
    
        /// (Required) Navigational links to related data and included resource types and IDs.
        public let relationships: BetaBuildLocalizationCreateRequest.Data.Relationships
    
        /// (Required) The resource type.Value: betaBuildLocalizations
        public let type: String = " betaBuildLocalizations"
    }
}

/// MARK: BetaBuildLocalizationCreateRequest.Data
extension BetaBuildLocalizationCreateRequest.Data {
    /// Attributes that describe a resource.
    public struct Attributes: Codable {
    
        /// (Required) The specified locale. Refer to Table 1 for possible values.
        public let locale: String
    
        /// A field that describes changes and additions to a build and indicates features you would like your users to test.
        public let whatsNew: String?
    }
    
    public struct Relationships: Codable {
    
        /// BetaBuildLocalizationCreateRequest.Data.Relationships.Build (Required)
        public let build: BetaBuildLocalizationCreateRequest.Data.Relationships.Build
    }
}

/// MARK: BetaBuildLocalizationCreateRequest.Data.Relationships
extension BetaBuildLocalizationCreateRequest.Data.Relationships {
    
    public struct Build: Codable {
    
        /// BetaBuildLocalizationCreateRequest.Data.Relationships.Build.Data (Required)
        public let data: BetaBuildLocalizationCreateRequest.Data.Relationships.Build.Data
    }
}

/// MARK: BetaBuildLocalizationCreateRequest.Data.Relationships.Build
extension BetaBuildLocalizationCreateRequest.Data.Relationships.Build {
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: builds
        public let type: String = " builds"
    }
}
