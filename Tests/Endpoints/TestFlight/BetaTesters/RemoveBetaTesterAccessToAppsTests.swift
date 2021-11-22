//
//  RemoveBetaTesterAccessToAppsTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 26/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class RemoveBetaTesterAccessToAppsTests: XCTestCase {

    func testURLRequest() {
        let appIds = ["appId"]
        let endpoint = APIEndpoint.remove(
            accessOfBetaTesterWithId: "betaTesterId",
            toAppsWithIds: appIds)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "DELETE")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaTesters/betaTesterId/relationships/apps"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(BetaTesterAppsLinkagesRequest(appIds)))
    }
}
