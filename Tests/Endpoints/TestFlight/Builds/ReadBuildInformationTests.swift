//
//  ReadBuildInformationTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ReadBuildInformationTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.build(
            withId: "id",
            fields: [
                .appEncryptionDeclarations(ReadBuildInformation.Field.AppEncryptionDeclaration.allCases),
                .apps(ReadBuildInformation.Field.App.allCases),
                .betaAppReviewSubmissions(ReadBuildInformation.Field.BetaAppReviewSubmission.allCases),
                .betaBuildLocalizations(ReadBuildInformation.Field.BetaBuildLocalization.allCases),
                .betaTesters(ReadBuildInformation.Field.BetaTester.allCases),
                .buildBetaDetails(ReadBuildInformation.Field.BuildBetaDetail.allCases),
                .builds(ReadBuildInformation.Field.Build.allCases),
                .preReleaseVersions(ReadBuildInformation.Field.PreReleaseVersion.allCases)],
            include: ReadBuildInformation.Include.allCases,
            limit: [
                .betaBuildLocalizations(1),
                .individualTesters(2)])
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds/id?fields%5BAppEncryptionDeclaration%5D=app%2CappEncryptionDeclarationState%2CavailableOnFrenchStore%2Cbuilds%2CcodeValue%2CcontainsProprietaryCryptography%2CcontainsThirdPartyCryptography%2CdocumentName%2CdocumentType%2CdocumentUrl%2Cexempt%2Cplatform%2CuploadedDate%2CusesEncryption&fields%5BApp%5D=betaAppLocalizations%2CbetaAppReviewDetail%2CbetaGroups%2CbetaLicenseAgreement%2CbetaTesters%2Cbuilds%2CbundleId%2Cname%2CpreReleaseVersions%2CprimaryLocale%2Csku&fields%5BbetaAppReviewSubmission%5D=betaReviewState%2Cbuild&fields%5BbetaBuildLocalization%5D=build%2Clocale%2CwhatsNew&fields%5BbetaTester%5D=apps%2CbetaGroups%2Cbuilds%2Cemail%2CfirstName%2CinviteType%2ClastName&fields%5BbuildBetaDetail%5D=autoNotifyEnabled%2Cbuild%2CexternalBuildState%2CinternalBuildState&fields%5Bbuild%5D=app%2CappEncryptionDeclaration%2CbetaAppReviewSubmission%2CbetaBuildLocalizations%2CbetaGroups%2CbuildBetaDetail%2CexpirationDate%2Cexpired%2CiconAssetToken%2CindividualTesters%2CminOsVersion%2CpreReleaseVersion%2CprocessingState%2CuploadedDate%2CusesNonExemptEncryption%2Cversion&fields%5BpreReleaseVersion%5D=app%2Cbuilds%2Cplatform%2Cversion&include=app%2CappEncryptionDeclaration%2CbetaAppReviewSubmission%2CbetaBuildLocalizations%2CbuildBetaDetail%2CindividualTesters%2CpreReleaseVersion&limit%5BbetaBuildLocalizations%5D=1&limit%5BindividualTesters%5D=2"
        XCTAssertEqual(absoluteString, expected)
    }
}
