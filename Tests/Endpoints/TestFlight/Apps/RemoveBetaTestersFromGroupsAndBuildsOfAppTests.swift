//
//  RemoveBetaTestersFromGroupsAndBuildsOfAppTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 26/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class RemoveBetaTestersFromGroupsAndBuildsOfAppTests: XCTestCase {

    func testURLRequest() {
        let betaTesterIds = ["betaTesterId"]
        let endpoint = APIEndpoint.remove(
            betaTestersWithIds: betaTesterIds,
            fromGroupsAndBuildsOfAppWithId: "appId")

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "DELETE")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/apps/appId/relationships/betaTesters"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(AppBetaTestersLinkagesRequest(betaTesterIds)))
    }
}
