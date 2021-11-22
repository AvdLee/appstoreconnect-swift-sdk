//
//  GetResourceIDsOfIndividualTestersForBuildTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class GetResourceIDsOfIndividualTestersForBuildTests: XCTestCase {

    func testURLRequest() {
        let endpoint = APIEndpoint.individualTestersIDs(
            ofForBuildWithId: "buildId",
            limit: 2)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds/buildId/relationships/individualTesters?limit=2"
        XCTAssertEqual(absoluteString, expected)
    }
}
