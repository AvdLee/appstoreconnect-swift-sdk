//
//  ListAppsVisibleToInvitedUserTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListAppsVisibleToInvitedUserTests: XCTestCase {
    
    func testURLRequest() {
        let buildId = "buildId"
        let endpoint = APIEndpoint.apps(
            visibleToInvitedUserWithId: "userId",
            fields: [.apps(ListAppsVisibleToInvitedUser.Field.App.allCases)],
            limit: 2)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/userInvitations/userId/visibleApps?fields%5Bapp%5D=betaAppLocalizations%2CbetaAppReviewDetail%2CbetaGroups%2CbetaLicenseAgreement%2CbetaTesters%2Cbuilds%2CbundleId%2Cname%2CpreReleaseVersions%2CprimaryLocale%2Csku&limit=2"
        XCTAssertEqual(absoluteString, expected)
    }
}
