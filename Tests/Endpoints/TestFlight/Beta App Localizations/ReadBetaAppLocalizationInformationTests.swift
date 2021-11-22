//
//  ReadBetaAppLocalizationInformationTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ReadBetaAppLocalizationInformationTests: XCTestCase {

    func testURLRequest() {
        let endpoint = APIEndpoint.betaAppLocalization(
            withId: "id",
            fields: [
                .apps(ReadBetaAppLocalizationInformation.Field.App.allCases),
                .betaAppLocalizations(ReadBetaAppLocalizationInformation.Field.BetaAppLocalization.allCases)],
            include: ReadBetaAppLocalizationInformation.Include.allCases)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaAppLocalizations/id?fields%5Bapp%5D=betaAppLocalizations%2CbetaAppReviewDetail%2CbetaGroups%2CbetaLicenseAgreement%2CbetaTesters%2Cbuilds%2CbundleId%2Cname%2CpreReleaseVersions%2CprimaryLocale%2Csku&fields%5BbetaAppLocalization%5D=app%2Cdescription%2CfeedbackEmail%2Clocale%2CmarketingUrl%2CprivacyPolicyUrl%2CtvOsPrivacyPolicy&include=app"
        XCTAssertEqual(absoluteString, expected)
    }
}
