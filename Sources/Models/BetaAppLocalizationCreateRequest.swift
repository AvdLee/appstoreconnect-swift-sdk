//
//  BetaAppLocalizationCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
public struct BetaAppLocalizationCreateRequest: Codable {

    /// (Required) The resource data.
    public let data: BetaAppLocalizationCreateRequest.Data
    
    public struct Data: Codable {
    
        /// (Required) The resource's attributes.
        public let attributes: BetaAppLocalizationCreateRequest.Data.Attributes
    
        /// (Required) Navigational links to related data and included resource types and IDs.
        public let relationships: BetaAppLocalizationCreateRequest.Data.Relationships
    
        /// (Required) The resource type.Value: betaAppLocalizations
        public let type: String = " betaAppLocalizations"
    }
}

/// MARK: BetaAppLocalizationCreateRequest.Data
extension BetaAppLocalizationCreateRequest.Data {
    /// Attributes that describe a resource.
    public struct Attributes: Codable {
    
        /// A description of your app that highlights features and functionality.
        public let description: String?
    
        /// An email address to which beta testers can send feedback. Also appears as the reply-to address for TestFlight invitation emails.
        public let feedbackEmail: String?
    
        /// (Required) The specified locale. Refer to Table 1 for possible values.
        public let locale: String
    
        /// A URL with information about your app. This URL is visible to testers in the TestFlight app.
        public let marketingUrl: String?
    
        /// A URL that links to your company’s privacy policy. Privacy policies are recommended for all apps that collect user or device-related data or as otherwise required by law.
        public let privacyPolicyUrl: String?
    
        /// Your company’s privacy policy. Privacy policies are recommended for all apps that collect user or device-related data, or as otherwise required by law.
        public let tvOsPrivacyPolicy: String?
    }
    
    public struct Relationships: Codable {
    
        /// BetaAppLocalizationCreateRequest.Data.Relationships.App (Required)
        public let app: BetaAppLocalizationCreateRequest.Data.Relationships.App
    }
}

/// MARK: BetaAppLocalizationCreateRequest.Data.Relationships
extension BetaAppLocalizationCreateRequest.Data.Relationships {
    
    public struct App: Codable {
    
        /// BetaAppLocalizationCreateRequest.Data.Relationships.App.Data (Required)
        public let data: BetaAppLocalizationCreateRequest.Data.Relationships.App.Data
    }
}

/// MARK: BetaAppLocalizationCreateRequest.Data.Relationships.App
extension BetaAppLocalizationCreateRequest.Data.Relationships.App {
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: apps
        public let type: String = " apps"
    }
}
