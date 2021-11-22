//
//  ModifyUserAccountTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ModifyUserAccountTests: XCTestCase {

    func testURLRequest() {
        let userId = "userId"
        let allAppsVisible = true
        let provisioningAllowed = false
        let roles = UserRole.allCases
        let appIds = ["appId"]

        let endpoint = APIEndpoint.modify(
            userWithId: userId,
            allAppsVisible: allAppsVisible,
            provisioningAllowed: provisioningAllowed,
            roles: roles,
            appsVisibleIds: appIds)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "PATCH")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/users/userId"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(UserUpdateRequest(
            id: userId,
            allAppsVisible: allAppsVisible,
            provisioningAllowed: provisioningAllowed,
            roles: roles,
            appsVisibleIds: appIds)))
    }
}
