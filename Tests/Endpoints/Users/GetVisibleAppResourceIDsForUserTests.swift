//
//  GetVisibleAppResourceIDsForUserTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class GetVisibleAppResourceIDsForUserTests: XCTestCase {

    func testURLRequest() {
        let endpoint = APIEndpoint.appIDs(visibleForUserWithId: "userId", limit: 2)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/users/userId/relationships/visibleApps?limit=2"
        XCTAssertEqual(absoluteString, expected)
    }
}
