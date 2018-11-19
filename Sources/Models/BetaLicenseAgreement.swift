//
//  BetaLicenseAgreement.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
public struct BetaLicenseAgreement: Decodable {

    /// The resource's attributes.
    public let attributes: BetaLicenseAgreement.Attributes?

    /// (Required) The opaque resource ID that uniquely identifies the resource.
    public let `id`: String

    /// (Required) Navigational links that include the self-link.
    public let links: ResourceLinks<BetaLicenseAgreementResponse>

    /// Navigational links to related data and included resource types and IDs.
    public let relationships: BetaLicenseAgreement.Relationships?

    /// (Required) The resource type.Value: betaLicenseAgreements
    public let type: String

    /// Attributes that describe a resource.
    public struct Attributes: Decodable {
    
        /// The license agreement text for your beta app that displays to users.
        public let agreementText: String?
    }
    
    public struct Relationships: Decodable {
    
        /// BetaLicenseAgreement.Relationships.App
        public let app: BetaLicenseAgreement.Relationships.App?
    }
}

/// MARK: BetaLicenseAgreement.Relationships
extension BetaLicenseAgreement.Relationships {
    
    public struct App: Decodable {
    
        /// BetaLicenseAgreement.Relationships.App.Data
        public let data: BetaLicenseAgreement.Relationships.App.Data?
    
        /// BetaLicenseAgreement.Relationships.App.Links
        public let links: BetaLicenseAgreement.Relationships.App.Links?
    }
}

/// MARK: BetaLicenseAgreement.Relationships.App
extension BetaLicenseAgreement.Relationships.App {
    
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
