//
//  ReadBetaGroupInformationTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ReadBetaGroupInformationTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.betaGroup(
            withId: "betaGroupId",
            fields: [.apps(ReadBetaGroupInformation.Field.App.allCases),
                     .betaGroups(ReadBetaGroupInformation.Field.BetaGroup.allCases),
                     .betaTesters(ReadBetaGroupInformation.Field.BetaTester.allCases),
                     .builds(ReadBetaGroupInformation.Field.Build.allCases)],
            include: ReadBetaGroupInformation.Include.allCases,
            limit: [.betaTesters(2),
                    .builds(1)])
        
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaGroups/betaGroupId?fields%5Bapp%5D=betaAppLocalizations%2CbetaAppReviewDetail%2CbetaGroups%2CbetaLicenseAgreement%2CbetaTesters%2Cbuilds%2CbundleId%2Cname%2CpreReleaseVersions%2CprimaryLocale%2Csku&fields%5BbetaGroup%5D=app%2CbetaTesters%2Cbuilds%2CcreatedDate%2CisInternalGroup%2Cname%2CpublicLink%2CpublicLinkEnabled%2CpublicLinkId%2CpublicLinkLimit%2CpublicLinkLimitEnabled&fields%5BbetaTester%5D=apps%2CbetaGroups%2Cbuilds%2Cemail%2CfirstName%2CinviteType%2ClastName&fields%5Bbuild%5D=app%2CappEncryptionDeclaration%2CbetaAppReviewSubmission%2CbetaBuildLocalizations%2CbetaGroups%2CbuildBetaDetail%2CexpirationDate%2Cexpired%2CiconAssetToken%2CindividualTesters%2CminOsVersion%2CpreReleaseVersion%2CprocessingState%2CuploadedDate%2CusesNonExemptEncryption%2Cversion&include=app%2CbetaTesters%2Cbuilds&limit%5BbetaTesters%5D=2&limit%5Bbuilds%5D=1"
        XCTAssertEqual(absoluteString, expected)
    }
}
