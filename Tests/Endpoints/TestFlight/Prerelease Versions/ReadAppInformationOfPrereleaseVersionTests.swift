//
//  ReadAppInformationOfPrereleaseVersionTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ReadAppInformationOfPrereleaseVersionTests: XCTestCase {

    func testURLRequest() {
        let endpoint = APIEndpoint.app(
            ofPrereleaseVersionWithId: "id",
            fields: [.apps(ReadAppInformationOfPrereleaseVersion.Field.App.allCases)])
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/preReleaseVersions/id/app?fields%5BApp%5D=betaAppLocalizations%2CbetaAppReviewDetail%2CbetaGroups%2CbetaLicenseAgreement%2CbetaTesters%2Cbuilds%2CbundleId%2Cname%2CpreReleaseVersions%2CprimaryLocale%2Csku"
        XCTAssertEqual(absoluteString, expected)
    }
}
