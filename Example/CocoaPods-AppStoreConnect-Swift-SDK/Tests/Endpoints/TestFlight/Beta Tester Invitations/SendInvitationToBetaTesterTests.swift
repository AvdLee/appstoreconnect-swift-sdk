//
//  SendInvitationToBetaTesterTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class SendInvitationToBetaTesterTests: XCTestCase {
    
    func testURLRequest() {
        let appId = "appId"
        let betaTesterId = "betaTesterId"
        let endpoint = APIEndpoint.send(
            invitationForAppWithId: appId,
            toBetaTesterWithId: betaTesterId)
        
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "POST")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaTesterInvitations"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(BetaTesterInvitationCreateRequest(appId: appId, betaTesterId: betaTesterId)))
    }
}
