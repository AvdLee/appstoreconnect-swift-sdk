//
//  BetaBuildLocalizationUpdateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
struct BetaBuildLocalizationUpdateRequest: Decodable {

    /// (Required) The resource data.
    let data: BetaBuildLocalizationUpdateRequest.Data

}

extension BetaBuildLocalizationUpdateRequest {
    
    struct Data: Decodable {
    
        /// The resource's attributes.
        let attributes: BetaBuildLocalizationUpdateRequest.Data.Attributes?
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: betaBuildLocalizations
        let type: String
    
    }
}

extension BetaBuildLocalizationUpdateRequest.Data {
    /// Attributes that describe a resource.
    struct Attributes: Decodable {
    
        /// A field that describes changes and additions to a build and indicates features you would like your users to test.
        let whatsNew: String?
    
    }
}
