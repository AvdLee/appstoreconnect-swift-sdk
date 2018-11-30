//
//  ListBetaAppLocalizationsTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListBetaAppLocalizationsTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.betaAppLocalizations(
            ofAppWithId: "id",
            fields: [.betaAppLocalizations(ListBetaAppLocalizationsForApp.Field.BetaAppLocalization.allCases)],
            limit: 2)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/apps/id/betaAppLocalizations?fields%5BbetaAppLocalization%5D=app%2Cdescription%2CfeedbackEmail%2Clocale%2CmarketingUrl%2CprivacyPolicyUrl%2CtvOsPrivacyPolicy&limit=2"
        XCTAssertEqual(absoluteString, expected)
    }
}
