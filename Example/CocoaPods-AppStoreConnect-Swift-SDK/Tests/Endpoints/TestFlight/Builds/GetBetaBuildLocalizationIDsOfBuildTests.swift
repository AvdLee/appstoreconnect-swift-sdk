//
//  GetBetaBuildLocalizationIDsOfBuildTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class GetBetaBuildLocalizationIDsOfBuildTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.betaBuildLocalizations(
            ofBuildWithId: "id",
            fields: [.betaBuildLocalizations(ListBetaBuildLocalizationsOfBuild.Field.BetaBuildLocalization.allCases)],
            limit: 2)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds/id/betaBuildLocalizations?fields%5BbetaBuildLocalization%5D=build%2Clocale%2CwhatsNew&limit=2"
        XCTAssertEqual(absoluteString, expected)
    }
}
