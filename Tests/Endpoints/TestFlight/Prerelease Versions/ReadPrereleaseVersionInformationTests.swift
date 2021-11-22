//
//  ReadPrereleaseVersionInformationTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ReadPrereleaseVersionInformationTests: XCTestCase {

    func testURLRequest() {
        let endpoint = APIEndpoint.prereleaseVersion(
            withId: "id",
            fields: [
                .apps(ReadPrereleaseVersionInformation.Field.App.allCases),
                .builds(ReadPrereleaseVersionInformation.Field.Build.allCases),
                .preReleaseVersions(ReadPrereleaseVersionInformation.Field.PreReleaseVersion.allCases)],
            include: ReadPrereleaseVersionInformation.Include.allCases,
            limit: [.builds(2)])
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/preReleaseVersions/id?fields%5BApp%5D=betaAppLocalizations%2CbetaAppReviewDetail%2CbetaGroups%2CbetaLicenseAgreement%2CbetaTesters%2Cbuilds%2CbundleId%2Cname%2CpreReleaseVersions%2CprimaryLocale%2Csku&fields%5Bbuild%5D=app%2CappEncryptionDeclaration%2CbetaAppReviewSubmission%2CbetaBuildLocalizations%2CbetaGroups%2CbuildBetaDetail%2CexpirationDate%2Cexpired%2CiconAssetToken%2CindividualTesters%2CminOsVersion%2CpreReleaseVersion%2CprocessingState%2CuploadedDate%2CusesNonExemptEncryption%2Cversion&fields%5BpreReleaseVersion%5D=app%2Cbuilds%2Cplatform%2Cversion&include=app%2Cbuilds&limit%5Bbuilds%5D=2"
        XCTAssertEqual(absoluteString, expected)
    }
}
