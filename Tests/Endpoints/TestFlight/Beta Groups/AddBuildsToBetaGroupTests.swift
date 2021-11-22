//
//  AddBuildsToBetaGroupTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class AddBuildsToBetaGroupTests: XCTestCase {

    func testURLRequest() {
        let buildIds = ["buildId"]
        let endpoint = APIEndpoint.add(buildsWithIds: buildIds, toBetaGroupWithId: "betaGroupId")

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "POST")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaGroups/betaGroupId/relationships/builds"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(BetaGroupBuildsLinkagesRequest(buildIds)))
    }
}
