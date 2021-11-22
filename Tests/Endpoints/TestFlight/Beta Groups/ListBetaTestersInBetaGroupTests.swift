//
//  ListBetaTestersInBetaGroupTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListBetaTestersInBetaGroupTests: XCTestCase {

    func testURLRequest() {
        let endpoint = APIEndpoint.betaTesters(
            inBetaGroupWithId: "betaGroupId",
            limit: 2,
            fields: [.betaTesters(ListBetaTestersInBetaGroup.Field.BetaTester.allCases)],
            next: .test)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaGroups/betaGroupId/betaTesters?cursor=NEXT&fields%5BbetaTester%5D=apps%2CbetaGroups%2Cbuilds%2Cemail%2CfirstName%2CinviteType%2ClastName&limit=2"
        XCTAssertEqual(absoluteString, expected)
    }
}
