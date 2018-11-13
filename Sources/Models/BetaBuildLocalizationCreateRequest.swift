//
//  BetaBuildLocalizationCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
struct BetaBuildLocalizationCreateRequest: Decodable {

    /// (Required) The resource data.
    let data: BetaBuildLocalizationCreateRequest.Data
    
    struct Data: Decodable {
    
        /// (Required) The resource's attributes.
        let attributes: BetaBuildLocalizationCreateRequest.Data.Attributes
    
        /// (Required) Navigational links to related data and included resource types and IDs.
        let relationships: BetaBuildLocalizationCreateRequest.Data.Relationships
    
        /// (Required) The resource type.Value: betaBuildLocalizations
        let type: String
    }
}

/// MARK: BetaBuildLocalizationCreateRequest.Data
extension BetaBuildLocalizationCreateRequest.Data {
    /// Attributes that describe a resource.
    struct Attributes: Decodable {
    
        /// (Required) The specified locale. Refer to Table 1 for possible values.
        let locale: String
    
        /// A field that describes changes and additions to a build and indicates features you would like your users to test.
        let whatsNew: String?
    }
    
    struct Relationships: Decodable {
    
        /// BetaBuildLocalizationCreateRequest.Data.Relationships.Build (Required)
        let build: BetaBuildLocalizationCreateRequest.Data.Relationships.Build
    }
}

/// MARK: BetaBuildLocalizationCreateRequest.Data.Relationships
extension BetaBuildLocalizationCreateRequest.Data.Relationships {
    
    struct Build: Decodable {
    
        /// BetaBuildLocalizationCreateRequest.Data.Relationships.Build.Data (Required)
        let data: BetaBuildLocalizationCreateRequest.Data.Relationships.Build.Data
    }
}

/// MARK: BetaBuildLocalizationCreateRequest.Data.Relationships.Build
extension BetaBuildLocalizationCreateRequest.Data.Relationships.Build {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: builds
        let type: String
    }
}
