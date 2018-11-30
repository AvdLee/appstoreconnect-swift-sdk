//
//  BetaAppLocalization.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
public struct BetaAppLocalization: Codable {

    /// The resource's attributes.
    public let attributes: BetaAppLocalization.Attributes?

    /// The opaque resource ID that uniquely identifies the resource.
    public let `id`: String

    /// Navigational links to related data and included resource types and IDs.
    public let relationships: BetaAppLocalization.Relationships?

    /// The resource type.Value: betaAppLocalizations
    public let type: String = "betaAppLocalizations"

    /// Navigational links that include the self-link.
    public let links: ResourceLinks<BetaAppLocalizationResponse>

    /// Attributes that describe a resource.
    public struct Attributes: Codable {
    
        /// A description of your app that highlights features and functionality.
        public let description: String?
    
        /// An email address to which beta testers can send feedback. Also appears as the reply-to address for TestFlight invitation emails.
        public let feedbackEmail: String?
    
        /// The specified locale. Refer to Table 1 for possible values.
        public let locale: String?
    
        /// A URL with information about your app. This URL is visible to testers in the TestFlight app.
        public let marketingUrl: String?
    
        /// A URL that links to your company’s privacy policy. Privacy policies are recommended for all apps that collect user or device-related data or as otherwise required by law.
        public let privacyPolicyUrl: String?
    
        /// Your company’s privacy policy. Privacy policies are recommended for all apps that collect user or device-related data, or as otherwise required by law.
        public let tvOsPrivacyPolicy: String?
    }
    
    public struct Relationships: Codable {
    
        /// BetaAppLocalization.Relationships.App
        public let app: BetaAppLocalization.Relationships.App?
    }
}

/// MARK: BetaAppLocalization.Relationships
extension BetaAppLocalization.Relationships {
    
    public struct App: Codable {
    
        /// BetaAppLocalization.Relationships.App.Data
        public let data: BetaAppLocalization.Relationships.App.Data?
    
        /// BetaAppLocalization.Relationships.App.Links
        public let links: BetaAppLocalization.Relationships.App.Links?
    }
}

/// MARK: BetaAppLocalization.Relationships.App
extension BetaAppLocalization.Relationships.App {
    
    public struct Data: Codable {
    
        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// The resource type.Value: apps
        public let type: String = "apps"
    }
    
    public struct Links: Codable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}
