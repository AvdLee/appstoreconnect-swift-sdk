//
//  ListInvitedUsersTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListInvitedUsersTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.invitedUsers(
            fields: [
                .apps(ListInvitedUsers.Field.App.allCases),
                .userInvitations(ListInvitedUsers.Field.UserInvitation.allCases)],
            include: ListInvitedUsers.Include.allCases,
            limit: [
                .users(1),
                .visibleApps(2)
            ],
            sort: ListInvitedUsers.Sort.allCases,
            filter: [
                .email(["email"]),
                .roles(["roles"]),
                .visibleApps(["visibleApps"])],
            next: .test)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/userInvitations?cursor=NEXT&fields%5Bapp%5D=betaAppLocalizations%2CbetaAppReviewDetail%2CbetaGroups%2CbetaLicenseAgreement%2CbetaTesters%2Cbuilds%2CbundleId%2Cname%2CpreReleaseVersions%2CprimaryLocale%2Csku&fields%5BuserInvitation%5D=allAppsVisible%2Cemail%2CexpirationDate%2CfirstName%2ClastName%2CprovisioningAllowed%2Croles%2CvisibleApps&filter%5Bemail%5D=email&filter%5Broles%5D=roles&filter%5BvisibleApps%5D=visibleApps&include=visibleApps&limit=1&limit%5BvisibleApps%5D=2&sort=%2Bemail%2C-email%2C%2BlastName%2C-lastName"
        XCTAssertEqual(absoluteString, expected)
    }
}
