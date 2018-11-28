//
//  GetPrereleaseVersionIDsForAppTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 26/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class GetPrereleaseVersionIDsForAppTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.prereleaseVersionIDsForApp(
            withId: "appId",
            limit: 1)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/apps/appId/relationships/preReleaseVersions?limit=1"
        XCTAssertEqual(absoluteString, expected)
    }
}
