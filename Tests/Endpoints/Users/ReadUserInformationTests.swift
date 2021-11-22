//
//  ReadUserInformationTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ReadUserInformationTests: XCTestCase {

    func testURLRequest() {
        let endpoint = APIEndpoint.user(
            withId: "appId",
            fields: [
                .apps(ReadUserInformation.Field.App.allCases),
                .users(ReadUserInformation.Field.User.allCases)],
            include: ReadUserInformation.Include.allCases,
            limit: [.visibleApps(2)])
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/users/appId?fields%5Bapp%5D=betaAppLocalizations%2CbetaAppReviewDetail%2CbetaGroups%2CbetaLicenseAgreement%2CbetaTesters%2Cbuilds%2CbundleId%2Cname%2CpreReleaseVersions%2CprimaryLocale%2Csku&fields%5Bser%5D=allAppsVisible%2CfirstName%2ClastName%2CprovisioningAllowed%2Croles%2Cusername%2CvisibleApps&include=visibleApps&limit%5BvisibleApps%5D=2"
        XCTAssertEqual(absoluteString, expected)
    }
}
