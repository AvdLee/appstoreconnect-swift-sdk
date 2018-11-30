//
//  GetBuildIDsOfPrereleaseVersionTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class GetBuildIDsOfPrereleaseVersionTests: XCTestCase {
    
    func testURLRequest() {
        let buildId = "id"
        let locale = "locale"
        let whatsNew = "whatsNew"
        
        let endpoint = APIEndpoint.create(
            betaBuildLocalizationForBuildWithId: buildId,
            locale: locale,
            whatsNew: whatsNew)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "POST")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaBuildLocalizations"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(BetaBuildLocalizationCreateRequest(
            buildId: buildId,
            locale: locale,
            whatsNew: whatsNew)))
    }
}
