//
//  ListBetaAppLocalizationsOfAppTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 26/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListBetaAppLocalizationsOfAppTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.betaAppLocalizationsOfApp(
            withId: "appId",
            fields: [.betaAppLocalizations(ListBetaAppLocalizationsForApp.Field.BetaAppLocalization.allCases)],
            limit: 1)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/apps/appId/betaAppLocalizations?fields%5BbetaAppLocalization%5D=app%2Cdescription%2CfeedbackEmail%2Clocale%2CmarketingUrl%2CprivacyPolicyUrl%2CtvOsPrivacyPolicy&limit=1"
        XCTAssertEqual(absoluteString, expected)
    }
}
