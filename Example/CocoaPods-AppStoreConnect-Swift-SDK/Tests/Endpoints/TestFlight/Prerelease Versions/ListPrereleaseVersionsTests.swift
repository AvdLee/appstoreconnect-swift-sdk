//
//  ListPrereleaseVersionsTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListPrereleaseVersionsTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.prereleaseVersions(
            forAppWithId: "id",
            fields: [.preReleaseVersions(ListPrereleaseVersionsForApp.Field.PreReleaseVersion.allCases)],
            limit: 2,
            next: .test)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/apps/id/preReleaseVersions?cursor=NEXT&fields%5BpreReleaseVersion%5D=app%2Cbuilds%2Cplatform%2Cversion&limit=2"
        XCTAssertEqual(absoluteString, expected)
    }
}
