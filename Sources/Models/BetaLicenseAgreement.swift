//
//  BetaLicenseAgreement.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
struct BetaLicenseAgreement: Decodable {

    /// The resource's attributes.
    let attributes: BetaLicenseAgreement.Attributes?

    /// (Required) The opaque resource ID that uniquely identifies the resource.
    let `id`: String

    /// (Required) Navigational links that include the self-link.
    let links: ResourceLinks

    /// Navigational links to related data and included resource types and IDs.
    let relationships: BetaLicenseAgreement.Relationships?

    /// (Required) The resource type.Value: betaLicenseAgreements
    let type: String

    /// Attributes that describe a resource.
    struct Attributes: Decodable {
    
        /// The license agreement text for your beta app that displays to users.
        let agreementText: String?
    }
    
    struct Relationships: Decodable {
    
        /// BetaLicenseAgreement.Relationships.App
        let app: BetaLicenseAgreement.Relationships.App?
    }
}

extension BetaLicenseAgreement.Relationships {
    
    struct App: Decodable {
    
        /// BetaLicenseAgreement.Relationships.App.Data
        let data: BetaLicenseAgreement.Relationships.App.Data?
    
        /// BetaLicenseAgreement.Relationships.App.Links
        let links: BetaLicenseAgreement.Relationships.App.Links?
    }
}

extension BetaLicenseAgreement.Relationships.App {
    
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
