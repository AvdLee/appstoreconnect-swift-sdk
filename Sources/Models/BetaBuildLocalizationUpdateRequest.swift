//
//  BetaBuildLocalizationUpdateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
public struct BetaBuildLocalizationUpdateRequest: Codable {

    /// - Parameters:
    ///   - id: The opaque resource ID that uniquely identifies the resource.
    ///   - whatsNew: A field that describes changes and additions to a build and indicates features you would like your users to test.
    init(id: String, whatsNew: String? = nil) {
        data = .init(attributes: .init(whatsNew: whatsNew), id: id)
    }
    
    /// (Required) The resource data.
    public let data: BetaBuildLocalizationUpdateRequest.Data

    public struct Data: Codable {
    
        /// The resource's attributes.
        public let attributes: BetaBuildLocalizationUpdateRequest.Data.Attributes?
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: betaBuildLocalizations
        public let type: String = "betaBuildLocalizations"
    }
}

/// MARK: BetaBuildLocalizationUpdateRequest.Data
extension BetaBuildLocalizationUpdateRequest.Data {
    /// Attributes that describe a resource.
    public struct Attributes: Codable {
    
        /// A field that describes changes and additions to a build and indicates features you would like your users to test.
        public let whatsNew: String?
    }
}
