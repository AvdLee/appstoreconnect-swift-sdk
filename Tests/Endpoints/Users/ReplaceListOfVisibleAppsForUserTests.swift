//
//  ReplaceListOfVisibleAppsForUserTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ReplaceListOfVisibleAppsForUserTests: XCTestCase {

    func testURLRequest() {
        let userId = "userId"
        let appIds = ["appId"]
        let endpoint = APIEndpoint.replaceListOfVisibleApps(
            forUserWithId: userId,
            withAppsWithIds: appIds)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "PATCH")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/users/userId/relationships/visibleApps"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(UserVisibleAppsLinkagesRequest(appIds)))
    }
}
