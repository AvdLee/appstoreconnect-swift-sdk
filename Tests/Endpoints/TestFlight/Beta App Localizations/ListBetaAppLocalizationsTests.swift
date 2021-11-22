//
//  ListBetaAppLocalizationsTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListBetaAppLocalizationsTests: XCTestCase {

    func testURLRequest() {
        let endpoint = APIEndpoint.betaAppLocalizations(
            fields: [
                .apps(ListBetaAppLocalizations.Field.App.allCases),
                .betaAppLocalizations(ListBetaAppLocalizations.Field.BetaAppLocalization.allCases)],
            filter: [
                .app(["appId"]),
                .locale(["locale"])],
            include: ListBetaAppLocalizations.Include.allCases,
            limit: 2,
            next: .test)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaAppLocalizations?cursor=NEXT&fields%5Bapp%5D=betaAppLocalizations%2CbetaAppReviewDetail%2CbetaGroups%2CbetaLicenseAgreement%2CbetaTesters%2Cbuilds%2CbundleId%2Cname%2CpreReleaseVersions%2CprimaryLocale%2Csku&fields%5BbetaAppLocalization%5D=app%2Cdescription%2CfeedbackEmail%2Clocale%2CmarketingUrl%2CprivacyPolicyUrl%2CtvOsPrivacyPolicy&filter%5Bapp%5D=appId&filter%5Blocale%5D=locale&include=app&limit=2"
        XCTAssertEqual(absoluteString, expected)
    }
}
