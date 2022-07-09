//
//  ModifyBetaAppLocalization.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

import Foundation

extension APIEndpoint where T == BetaAppLocalizationResponse {

    /// Update the localized What’s New text for a specific app and locale.
    ///
    /// - Parameters:
    ///   - id: The opaque resource ID that uniquely identifies the resource.
    ///   - description: A description of your app that highlights features and functionality.
    ///   - feedbackEmail: An email address to which beta testers can send feedback. Also appears as the reply-to address for TestFlight invitation emails.
    ///   - marketingUrl: A URL with information about your app. This URL is visible to testers in the TestFlight app
    ///   - privacyPolicyUrl: A URL that links to your company’s privacy policy. Privacy policies are recommended for all apps that collect user or device-related data or as otherwise required by law.
    ///   - tvOsPrivacyPolicy: Your company’s privacy policy. Privacy policies are recommended for all apps that collect user or device-related data, or as otherwise required by law.
    public static func modify(
        betaAppLocalizationWithId id: String,
        description: String? = nil,
        feedbackEmail: String? = nil,
        marketingUrl: String? = nil,
        privacyPolicyUrl: String? = nil,
        tvOsPrivacyPolicy: String? = nil) -> APIEndpoint {
        let request = BetaAppLocalizationUpdateRequest(
            id: id,
            description: description,
            feedbackEmail: feedbackEmail,
            marketingUrl: marketingUrl,
            privacyPolicyUrl: privacyPolicyUrl,
            tvOsPrivacyPolicy: tvOsPrivacyPolicy)
        return APIEndpoint(
            path: "betaAppLocalizations/\(id)",
            method: .patch,
            parameters: nil,
            body: try? JSONEncoder().encode(request))
    }
}
