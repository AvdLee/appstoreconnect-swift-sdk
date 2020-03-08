//
//  AddVisibleAppsToUserTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class AddVisibleAppsToUserTests: XCTestCase {
    
    func testURLRequest() {
        let appIds = ["appId"]
        let endpoint = APIEndpoint.add(
            visibleAppsWithIds: appIds, toUserWithId: "userId")
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "POST")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/users/userId/relationships/visibleApps"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(UserVisibleAppsLinkagesRequest(appIds)))
    }
}
