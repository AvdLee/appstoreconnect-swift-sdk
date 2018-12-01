//
//  CancelUserInvitationTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class CancelUserInvitationTests: XCTestCase {
    
    func testURLRequest() {
        let userId = "userId"
        let endpoint = APIEndpoint.cancel(
            userInvitationWithId: userId)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "DELETE")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/userInvitations/userId"
        XCTAssertEqual(absoluteString, expected)
    }
}
