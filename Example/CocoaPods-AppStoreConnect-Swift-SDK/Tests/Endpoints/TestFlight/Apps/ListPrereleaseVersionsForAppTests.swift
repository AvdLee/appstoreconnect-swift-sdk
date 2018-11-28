//
//  ListPrereleaseVersionsForAppTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 26/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListPrereleaseVersionsForAppTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.prereleaseVersionsForApp(
            withId: "appId",
            fields: [.preReleaseVersions(ListPrereleaseVersionsForApp.Field.PreReleaseVersion.allCases)],
            limit: 1)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/apps/appId/preReleaseVersions?fields%5BpreReleaseVersion%5D=app%2Cbuilds%2Cplatform%2Cversion&limit=1"
        XCTAssertEqual(absoluteString, expected)
    }
}
