//
//  ListBetaGroupsToWhichBetaTesterBelongsTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 26/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListBetaGroupsToWhichBetaTesterBelongsTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.betaGroups(
            toWhichBelongBetaTesterWithId: "betaTesterId",
            limit: 1,
            fields: [.betaGroups(ListBetaGroupsToWhichBetaTesterBelongs.Field.BetaGroup.allCases)],
            next: .test)
        
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaTesters/betaTesterId/betaGroups?cursor=NEXT&fields%5BbetaGroup%5D=app%2CbetaTesters%2Cbuilds%2CcreatedDate%2CisInternalGroup%2Cname%2CpublicLink%2CpublicLinkEnabled%2CpublicLinkId%2CpublicLinkLimit%2CpublicLinkLimitEnabled&limit=1"
        XCTAssertEqual(absoluteString, expected)
    }
}
