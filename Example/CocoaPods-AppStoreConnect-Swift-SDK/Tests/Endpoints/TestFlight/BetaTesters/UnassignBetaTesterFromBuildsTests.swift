//
//  UnassignBetaTesterFromBuildsTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 26/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class UnassignBetaTesterFromBuildsTests: XCTestCase {
    
    func testURLRequest() {
        let buildIds = ["buildId"]
        let endpoint = APIEndpoint.unassign(
            betaTesterWithId: "betaTesterId",
            fromBuildsWithIds: buildIds)
        
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "DELETE")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaTesters/betaTesterId/relationships/builds"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(BetaTesterBuildsLinkagesRequest(buildIds)))
    }
}
