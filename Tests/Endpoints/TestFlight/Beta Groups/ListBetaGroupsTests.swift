//
//  ListBetaGroupsTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListBetaGroupsTests: XCTestCase {

    func testURLRequest() {
        let endpoint = APIEndpoint.betaGroups(
            fields: [
                .apps(ListBetaGroups.Field.App.allCases),
                .betaGroups(ListBetaGroups.Field.BetaGroup.allCases),
                .betaTesters(ListBetaGroups.Field.BetaTester.allCases),
                .builds(ListBetaGroups.Field.Build.allCases)],
            filter: [
                .app(["app"]),
                .builds(["builds"]),
                .id(["id"]),
                .isInternalGroup(["isInternalGroup"]),
                .name(["name"]),
                .publicLink(["publicLink"]),
                .publicLinkEnabled(["publicLinkEnabled"]),
                .publicLinkLimitEnabled(["publicLinkLimitEnabled"])],
            include: ListBetaGroups.Include.allCases,
            limit: [
                .betaTesters(2),
                .builds(1)],
            sort: ListBetaGroups.Sort.allCases,
            next: .test)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaGroups?cursor=NEXT&fields%5Bapp%5D=betaAppLocalizations%2CbetaAppReviewDetail%2CbetaGroups%2CbetaLicenseAgreement%2CbetaTesters%2Cbuilds%2CbundleId%2Cname%2CpreReleaseVersions%2CprimaryLocale%2Csku&fields%5BbetaGroup%5D=app%2CbetaTesters%2Cbuilds%2CcreatedDate%2CisInternalGroup%2Cname%2CpublicLink%2CpublicLinkEnabled%2CpublicLinkId%2CpublicLinkLimit%2CpublicLinkLimitEnabled&fields%5BbetaTester%5D=apps%2CbetaGroups%2Cbuilds%2Cemail%2CfirstName%2CinviteType%2ClastName&fields%5Bbuild%5D=app%2CappEncryptionDeclaration%2CbetaAppReviewSubmission%2CbetaBuildLocalizations%2CbetaGroups%2CbuildBetaDetail%2CexpirationDate%2Cexpired%2CiconAssetToken%2CindividualTesters%2CminOsVersion%2CpreReleaseVersion%2CprocessingState%2CuploadedDate%2CusesNonExemptEncryption%2Cversion&filter%5Bapp%5D=app&filter%5Bbuilds%5D=builds&filter%5Bid%5D=id&filter%5BisInternalGroup%5D=isInternalGroup&filter%5Bname%5D=name&filter%5BpublicLinkEnabled%5D=publicLinkEnabled&filter%5BpublicLinkLimitEnabled%5D=publicLinkLimitEnabled&filter%5BpublicLink%5D=publicLink&include=app%2CbetaTesters%2Cbuilds&limit%5BbetaTesters%5D=2&limit%5Bbuilds%5D=1&sort=%2BcreatedDate%2C-createdDate%2C%2Bname%2C-name%2C%2BpublicLinkEnabled%2C-publicLinkEnabled%2C%2BpublicLinkLimit%2C-publicLinkLimit"
        XCTAssertEqual(absoluteString, expected)
    }
}
