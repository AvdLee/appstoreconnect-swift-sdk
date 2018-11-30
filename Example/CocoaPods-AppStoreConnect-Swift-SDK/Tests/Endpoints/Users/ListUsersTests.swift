//
//  ListUsersTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListUsersTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.users(
            fields: [
                .apps(ListUsers.Field.App.allCases),
                .users(ListUsers.Field.User.allCases)],
            include: ListUsers.Include.allCases,
            limit: [ListUsers.Limit.visibleApps(2)],
            sort: ListUsers.Sort.allCases,
            filter: [
                .roles(["roles"]),
                .username(["username"]),
                .visibleApps(["visibleApps"])])
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/users?fields%5Bapp%5D=betaAppLocalizations%2CbetaAppReviewDetail%2CbetaGroups%2CbetaLicenseAgreement%2CbetaTesters%2Cbuilds%2CbundleId%2Cname%2CpreReleaseVersions%2CprimaryLocale%2Csku&fields%5Buser%5D=allAppsVisible%2CfirstName%2ClastName%2CprovisioningAllowed%2Croles%2Cusername%2CvisibleApps&filter%5Broles%5D=roles&filter%5Busername%5D=username&filter%5BvisibleApps%5D=visibleApps&include=visibleApps&limit%5BvisibleApps%5D=2&sort=%2BlastName%2C-lastName%2C%2Busername%2C-username"
        XCTAssertEqual(absoluteString, expected)
    }
}
