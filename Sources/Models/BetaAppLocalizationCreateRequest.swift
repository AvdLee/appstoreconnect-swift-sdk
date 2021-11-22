//
//  BetaAppLocalizationCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation

/// A request containing a single resource.
public struct BetaAppLocalizationCreateRequest: Codable {

    public struct Data: Codable {

        /// The resource's attributes.
        public let attributes: BetaAppLocalizationCreateRequest.Data.Attributes

        /// Navigational links to related data and included resource types and IDs.
        public let relationships: BetaAppLocalizationCreateRequest.Data.Relationships

        /// The resource type.Value: betaAppLocalizations
        public private(set) var type: String = "betaAppLocalizations"
    }

    /// The resource data.
    public let data: BetaAppLocalizationCreateRequest.Data

    /// - Parameters:
    ///   - appId: The opaque resource ID that uniquely identifies the resource.
    ///   - description: A description of your app that highlights features and functionality.
    ///   - feedbackEmail: An email address to which beta testers can send feedback. Also appears as the reply-to address for TestFlight invitation emails.
    ///   - locale: The specified locale. Refer to Table 1 for possible values.
    ///   - marketingUrl: A URL with information about your app. This URL is visible to testers in the TestFlight app.
    ///   - privacyPolicyUrl: A URL that links to your company’s privacy policy. Privacy policies are recommended for all apps that collect user or device-related data or as otherwise required by law.
    ///   - tvOsPrivacyPolicy: Your company’s privacy policy. Privacy policies are recommended for all apps that collect user or device-related data, or as otherwise required by law.
    init(appId: String,
         description: String? = nil,
         feedbackEmail: String? = nil,
         locale: String,
         marketingUrl: String? = nil,
         privacyPolicyUrl: String? = nil,
         tvOsPrivacyPolicy: String? = nil) {
        data = .init(
            attributes: .init(
                description: description,
                feedbackEmail: feedbackEmail,
                locale: locale,
                marketingUrl: marketingUrl,
                privacyPolicyUrl: privacyPolicyUrl,
                tvOsPrivacyPolicy: tvOsPrivacyPolicy),
            relationships: .init(app: .init(data: .init(id: appId))))
    }
}

// MARK: BetaAppLocalizationCreateRequest.Data
extension BetaAppLocalizationCreateRequest.Data {
    /// Attributes that describe a resource.
    public struct Attributes: Codable {

        /// A description of your app that highlights features and functionality.
        public let description: String?

        /// An email address to which beta testers can send feedback. Also appears as the reply-to address for TestFlight invitation emails.
        public let feedbackEmail: String?

        /// The specified locale. Refer to Table 1 for possible values.
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

// MARK: BetaAppLocalizationCreateRequest.Data.Relationships
extension BetaAppLocalizationCreateRequest.Data.Relationships {

    public struct App: Codable {

        /// BetaAppLocalizationCreateRequest.Data.Relationships.App.Data (Required)
        public let data: BetaAppLocalizationCreateRequest.Data.Relationships.App.Data
    }
}

// MARK: BetaAppLocalizationCreateRequest.Data.Relationships.App
extension BetaAppLocalizationCreateRequest.Data.Relationships.App {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: apps
        public private(set) var type: String = "apps"
    }
}
