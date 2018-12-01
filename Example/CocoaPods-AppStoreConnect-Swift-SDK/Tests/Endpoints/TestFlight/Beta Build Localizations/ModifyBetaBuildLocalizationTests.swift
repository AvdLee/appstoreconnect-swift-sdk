//
//  ModifyBetaBuildLocalizationTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ModifyBetaBuildLocalizationTests: XCTestCase {
    
    func testURLRequest() {
        let betaBuildLocalizationId = "id"
        let whatsNew = "whatsNew"
        
        let endpoint = APIEndpoint.modify(
            betaBuildLocalizationWithId: betaBuildLocalizationId,
            whatsNew: whatsNew)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "PATCH")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaBuildLocalizations/id"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(BetaBuildLocalizationUpdateRequest(
            id: betaBuildLocalizationId,
            whatsNew: whatsNew)))
    }
}
