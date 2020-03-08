//
//  ModifyBetaGroupTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ModifyBetaGroupTests: XCTestCase {
    
    func testURLRequest() {
        let betaGroupId = "betaGroupId"
        let name = "name"
        let publicLinkEnabled = true
        let publicLinkLimit = 2
        let publicLinkLimitEnabled = false
        
        let endpoint = APIEndpoint.modify(
            betaGroupWithId: betaGroupId,
            name: name,
            publicLinkEnabled: publicLinkEnabled,
            publicLinkLimit: publicLinkLimit,
            publicLinkLimitEnabled: publicLinkLimitEnabled)
        
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "PATCH")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaGroups/betaGroupId"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(BetaGroupUpdateRequest(
            id: betaGroupId,
            name: name,
            publicLinkEnabled: publicLinkEnabled,
            publicLinkLimit: publicLinkLimit,
            publicLinkLimitEnabled: publicLinkLimitEnabled)))
    }
}
