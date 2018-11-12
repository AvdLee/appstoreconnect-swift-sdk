//
//  BetaAppLocalizationCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
struct BetaAppLocalizationCreateRequest: Decodable {

    /// (Required) The resource data.
    let data: BetaAppLocalizationCreateRequest.Data
    
    struct Data: Decodable {
    
        /// (Required) The resource's attributes.
        let attributes: BetaAppLocalizationCreateRequest.Data.Attributes
    
        /// (Required) Navigational links to related data and included resource types and IDs.
        let relationships: BetaAppLocalizationCreateRequest.Data.Relationships
    
        /// (Required) The resource type.Value: betaAppLocalizations
        let type: String
    }
}

/// MARK: BetaAppLocalizationCreateRequest.Data
extension BetaAppLocalizationCreateRequest.Data {
    /// Attributes that describe a resource.
    struct Attributes: Decodable {
    
        /// A description of your app that highlights features and functionality.
        let description: String?
    
        /// An email address to which beta testers can send feedback. Also appears as the reply-to address for TestFlight invitation emails.
        let feedbackEmail: String?
    
        /// (Required) The specified locale. Refer to Table 1 for possible values.
        let locale: String
    
        /// A URL with information about your app. This URL is visible to testers in the TestFlight app.
        let marketingUrl: String?
    
        /// A URL that links to your company’s privacy policy. Privacy policies are recommended for all apps that collect user or device-related data or as otherwise required by law.
        let privacyPolicyUrl: String?
    
        /// Your company’s privacy policy. Privacy policies are recommended for all apps that collect user or device-related data, or as otherwise required by law.
        let tvOsPrivacyPolicy: String?
    }
    
    struct Relationships: Decodable {
    
        /// BetaAppLocalizationCreateRequest.Data.Relationships.App (Required)
        let app: BetaAppLocalizationCreateRequest.Data.Relationships.App
    }
}

/// MARK: BetaAppLocalizationCreateRequest.Data.Relationships
extension BetaAppLocalizationCreateRequest.Data.Relationships {
    
    struct App: Decodable {
    
        /// BetaAppLocalizationCreateRequest.Data.Relationships.App.Data (Required)
        let data: BetaAppLocalizationCreateRequest.Data.Relationships.App.Data
    }
}

/// MARK: BetaAppLocalizationCreateRequest.Data.Relationships.App
extension BetaAppLocalizationCreateRequest.Data.Relationships.App {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: apps
        let type: String
    }
}
