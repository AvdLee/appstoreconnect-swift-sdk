//
//  GetBetaAppLocalizationIDsOfAppTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 26/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class GetBetaAppLocalizationIDsOfAppTests: XCTestCase {

    func testURLRequest() {
        let endpoint = APIEndpoint.betaAppLocalizationIDs(ofAppWithId: "appId", limit: 3)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/apps/appId/relationships/betaAppLocalizations?limit=3"
        XCTAssertEqual(absoluteString, expected)
    }
}
