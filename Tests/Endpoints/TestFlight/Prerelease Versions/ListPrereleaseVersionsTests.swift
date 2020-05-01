//
//  ListPrereleaseVersionsTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListPrereleaseVersionsTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.prereleaseVersions(
            fields: [
                .apps(ListPrereleaseVersions.Field.App.allCases),
                .builds(ListPrereleaseVersions.Field.Build.allCases),
                .preReleaseVersions(ListPrereleaseVersions.Field.PreReleaseVersion.allCases)],
            filter: [
                .app(["appID"]),
                .builds(["buildId"]),
                .buildsExpired(["expired"]),
                .buildsProcessingState(ListPrereleaseVersions.Filter.BuildsProcessingState.allCases),
                .platform(["platform"]),
                .version(["version"])],
            include: ListPrereleaseVersions.Include.allCases,
            limit: [.builds(2)],
            sort: ListPrereleaseVersions.Sort.allCases,
            next: .test)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/preReleaseVersions?cursor=NEXT&fields%5BApp%5D=betaAppLocalizations%2CbetaAppReviewDetail%2CbetaGroups%2CbetaLicenseAgreement%2CbetaTesters%2Cbuilds%2CbundleId%2Cname%2CpreReleaseVersions%2CprimaryLocale%2Csku&fields%5Bbuild%5D=app%2CappEncryptionDeclaration%2CbetaAppReviewSubmission%2CbetaBuildLocalizations%2CbetaGroups%2CbuildBetaDetail%2CexpirationDate%2Cexpired%2CiconAssetToken%2CindividualTesters%2CminOsVersion%2CpreReleaseVersion%2CprocessingState%2CuploadedDate%2CusesNonExemptEncryption%2Cversion&fields%5BpreReleaseVersion%5D=app%2Cbuilds%2Cplatform%2Cversion&filter%5Bapp%5D=appID&filter%5Bbuilds.expired%5D=expired&filter%5Bbuilds.processingState%5D=PROCESSING%2CFAILED%2CINVALID%2CVALID&filter%5Bbuilds%5D=buildId&filter%5Bplatform%5D=platform&filter%5Bversion%5D=version&include=app%2Cbuilds&limit%5Bbuilds%5D=2&sort=%2Bversion%2C-version"
        XCTAssertEqual(absoluteString, expected)
    }
}
