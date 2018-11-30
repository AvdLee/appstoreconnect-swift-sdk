//
//  AddBetaTesterToBetaGroupsTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 26/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class AddBetaTesterToBetaGroupsTests: XCTestCase {
    
    func testURLRequest() {
        let betaGroupIds = ["betaGroupId"]
        let endpoint = APIEndpoint.add(betaTesterWithId: "betaTesterId", toBetaGroupsWithIds: betaGroupIds)
        
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "POST")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaTesters/betaTesterId/relationships/betaGroups"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(BetaTesterBetaGroupsLinkagesRequest(betaGroupIds)))
    }
}
