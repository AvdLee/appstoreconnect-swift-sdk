//
//  CreateBetaGroupTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class CreateBetaGroupTests: XCTestCase {
    
    func testURLRequest() {
        let appId = "appId"
        let name = "name"
        let publicLinkEnabled = true
        let publicLinkLimit = 2
        let publicLinkLimitEnabled = false
        let betaTesterIds = ["betaTesterId"]
        let buildIds = ["buildId"]
        
        let endpoint = APIEndpoint.create(
            betaGroupForAppWithId: appId,
            name: name,
            publicLinkEnabled: publicLinkEnabled,
            publicLinkLimit: publicLinkLimit,
            publicLinkLimitEnabled: publicLinkLimitEnabled,
            betaTesterIds: betaTesterIds,
            buildIds: buildIds)
        
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "POST")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaGroups"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(BetaGroupCreateRequest(
            appId: appId,
            name: name,
            publicLinkEnabled: publicLinkEnabled,
            publicLinkLimit: publicLinkLimit,
            publicLinkLimitEnabled: publicLinkLimitEnabled,
            betaTesterIds: betaTesterIds,
            buildIds: buildIds)))
    }
}
