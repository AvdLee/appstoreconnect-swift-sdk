//
//  GetBetaAppReviewDetailsResourceOfAppTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 26/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class GetBetaAppReviewDetailsResourceOfAppTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.betaAppReviewDetailsResourceOfApp(
            withId: "appId",
            fields: [.betaAppReviewDetails(GetBetaAppReviewDetailsResourceForApp.Field.BetaAppReviewDetail.allCases)])
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/apps/appId/betaAppReviewDetail?fields%5BbetaAppReviewDetail%5D=app%2CcontactEmail%2CcontactFirstName%2CcontactLastName%2CcontactPhone%2CdemoAccountName%2CdemoAccountPassword%2CdemoAccountRequired%2Cnotes"
        XCTAssertEqual(absoluteString, expected)
    }
}
