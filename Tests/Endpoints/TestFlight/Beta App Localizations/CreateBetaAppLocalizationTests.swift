//
//  CreateBetaAppLocalizationTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class CreateBetaAppLocalizationTests: XCTestCase {

    func testURLRequest() {
        let appId = "id"
        let locale = "locale"
        let description = "description"
        let feedbackEmail = "feedbackEmail"
        let marketingUrl = "marketingUrl"
        let privacyPolicyUrl = "privacyPolicyUrl"
        let tvOsPrivacyPolicy = "tvOsPrivacyPolicy"

        let endpoint = APIEndpoint.create(
            betaAppLocalizationForAppWithId: appId,
            locale: locale,
            description: description,
            feedbackEmail: feedbackEmail,
            marketingUrl: marketingUrl,
            privacyPolicyUrl: privacyPolicyUrl,
            tvOsPrivacyPolicy: tvOsPrivacyPolicy)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "POST")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaAppLocalizations"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(BetaAppLocalizationCreateRequest(
            appId: appId,
            description: description,
            feedbackEmail: feedbackEmail,
            locale: locale,
            marketingUrl: marketingUrl,
            privacyPolicyUrl: privacyPolicyUrl,
            tvOsPrivacyPolicy: tvOsPrivacyPolicy)))
    }
}
