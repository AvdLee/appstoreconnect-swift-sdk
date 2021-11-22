//
//  RemoveBuildsFromBetaGroupTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class RemoveBuildsFromBetaGroupTests: XCTestCase {

    func testURLRequest() {
        let buildIds = ["buildId"]
        let endpoint = APIEndpoint.remove(
            buildsWithIds: buildIds,
            fromBetaGroupWithId: "betaGroupId")

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "DELETE")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaGroups/betaGroupId/relationships/builds"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(BetaGroupBuildsLinkagesRequest(buildIds)))
    }
}
