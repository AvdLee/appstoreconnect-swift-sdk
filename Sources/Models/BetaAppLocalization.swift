//
//  BetaAppLocalization.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
struct BetaAppLocalization: Decodable {

    /// The resource's attributes.
    let attributes: BetaAppLocalization.Attributes?

    /// (Required) The opaque resource ID that uniquely identifies the resource.
    let `id`: String

    /// Navigational links to related data and included resource types and IDs.
    let relationships: BetaAppLocalization.Relationships?

    /// (Required) The resource type.Value: betaAppLocalizations
    let type: String

    /// (Required) Navigational links that include the self-link.
    let links: ResourceLinks

    /// Attributes that describe a resource.
    struct Attributes: Decodable {
    
        /// A description of your app that highlights features and functionality.
        let description: String?
    
        /// An email address to which beta testers can send feedback. Also appears as the reply-to address for TestFlight invitation emails.
        let feedbackEmail: String?
    
        /// The specified locale. Refer to Table 1 for possible values.
        let locale: String?
    
        /// A URL with information about your app. This URL is visible to testers in the TestFlight app.
        let marketingUrl: String?
    
        /// A URL that links to your company’s privacy policy. Privacy policies are recommended for all apps that collect user or device-related data or as otherwise required by law.
        let privacyPolicyUrl: String?
    
        /// Your company’s privacy policy. Privacy policies are recommended for all apps that collect user or device-related data, or as otherwise required by law.
        let tvOsPrivacyPolicy: String?
    }
    
    struct Relationships: Decodable {
    
        /// BetaAppLocalization.Relationships.App
        let app: BetaAppLocalization.Relationships.App?
    }
}

/// MARK: BetaAppLocalization.Relationships
extension BetaAppLocalization.Relationships {
    
    struct App: Decodable {
    
        /// BetaAppLocalization.Relationships.App.Data
        let data: BetaAppLocalization.Relationships.App.Data?
    
        /// BetaAppLocalization.Relationships.App.Links
        let links: BetaAppLocalization.Relationships.App.Links?
    }
}

/// MARK: BetaAppLocalization.Relationships.App
extension BetaAppLocalization.Relationships.App {
    
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
