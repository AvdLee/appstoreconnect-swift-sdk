//
//  ListIndividualTestersForBuildTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListIndividualTestersForBuildTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.individualTesters(
            forBuildWithId: "buildID",
            limit: 2,
            fields: [.betaTesters(ListIndividualTestersForBuild.Field.BetaTester.allCases)],
            next: .test)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds/buildID/individualTesters?cursor=NEXT&fields%5BbetaTester%5D=apps%2CbetaGroups%2Cbuilds%2Cemail%2CfirstName%2CinviteType%2ClastName&limit=2"
        XCTAssertEqual(absoluteString, expected)
    }
}
