//
//  GetBetaTesterTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 26/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class GetBetaTesterTests: XCTestCase {

    func testURLRequest() {
        let endpoint = APIEndpoint.betaTester(
            withId: "betaTesterId",
            fields: [
                .apps(GetBetaTester.Field.App.allCases),
                .betaGroups(GetBetaTester.Field.BetaGroup.allCases),
                .betaTesters(GetBetaTester.Field.BetaTester.allCases),
                .builds(GetBetaTester.Field.Build.allCases)],
            include: GetBetaTester.Include.allCases,
            limit: [
                .apps(1),
                .betaGroups(2),
                .builds(4)])

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaTesters/betaTesterId?fields%5Bapp%5D=betaAppLocalizations%2CbetaAppReviewDetail%2CbetaGroups%2CbetaLicenseAgreement%2CbetaTesters%2Cbuilds%2CbundleId%2Cname%2CpreReleaseVersions%2CprimaryLocale%2Csku&fields%5BbetaGroup%5D=app%2CbetaTesters%2Cbuilds%2CcreatedDate%2CisInternalGroup%2Cname%2CpublicLink%2CpublicLinkEnabled%2CpublicLinkId%2CpublicLinkLimit%2CpublicLinkLimitEnabled&fields%5BbetaTester%5D=apps%2CbetaGroups%2Cbuilds%2Cemail%2CfirstName%2CinviteType%2ClastName&fields%5Bbuild%5D=app%2CappEncryptionDeclaration%2CbetaAppReviewSubmission%2CbetaBuildLocalizations%2CbetaGroups%2CbuildBetaDetail%2CexpirationDate%2Cexpired%2CiconAssetToken%2CindividualTesters%2CminOsVersion%2CpreReleaseVersion%2CprocessingState%2CuploadedDate%2CusesNonExemptEncryption%2Cversion&include=apps%2CbetaGroups%2Cbuilds&limit%5Bapps%5D=1&limit%5BbetaGroups%5D=2&limit%5Bbuilds%5D=4"
        XCTAssertEqual(absoluteString, expected)
    }
}
