//
//  InviteUserTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class InviteUserTests: XCTestCase {

    func testURLRequest() {
        let email = "pakko972@me.com"
        let firstName = "firstName"
        let lastName = "lastName"
        let roles = UserRole.allCases
        let allAppsVisible = true
        let provisioningAllowed = false
        let appIds = ["appId"]

        let endpoint = APIEndpoint.invite(
            userWithEmail: email,
            firstName: firstName,
            lastName: lastName,
            roles: roles,
            allAppsVisible: allAppsVisible,
            provisioningAllowed: provisioningAllowed,
            appsVisibleIds: appIds)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "POST")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/userInvitations"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(UserInvitationCreateRequest(
            email: email,
            firstName: firstName,
            lastName: lastName,
            roles: roles,
            allAppsVisible: allAppsVisible,
            provisioningAllowed: provisioningAllowed,
            appsVisibleIds: appIds)))
    }
}
