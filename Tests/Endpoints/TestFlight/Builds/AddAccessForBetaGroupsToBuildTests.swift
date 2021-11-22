//
//  AddAccessForBetaGroupsToBuildTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class AddAccessForBetaGroupsToBuildTests: XCTestCase {

    func testURLRequest() {
        let betaGroupIds = ["betaGroupId"]
        let buildId = "buildId"

        let endpoint = APIEndpoint.add(
            accessForBetaGroupsWithIds: betaGroupIds,
            toBuildWithId: buildId)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "POST")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds/buildId/relationships/betaGroups"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(BuildBetaGroupsLinkagesRequest(betaGroupIds)))
    }
}
