//
//  ModifyBetaAppLocalizationTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ModifyBetaAppLocalizationTests: XCTestCase {

    func testURLRequest() {
        let betaAppLocalizationId = "id"
        let description = "description"
        let feedbackEmail = "feedbackEmail"
        let marketingUrl = "marketingUrl"
        let privacyPolicyUrl = "privacyPolicyUrl"
        let tvOsPrivacyPolicy = "tvOsPrivacyPolicy"

        let endpoint = APIEndpoint.modify(
            betaAppLocalizationWithId: betaAppLocalizationId,
            description: description,
            feedbackEmail: feedbackEmail,
            marketingUrl: marketingUrl,
            privacyPolicyUrl: privacyPolicyUrl,
            tvOsPrivacyPolicy: tvOsPrivacyPolicy)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "PATCH")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaAppLocalizations/id"
        XCTAssertEqual(absoluteString, expected)
    }
}
