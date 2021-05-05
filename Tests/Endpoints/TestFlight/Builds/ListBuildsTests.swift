//
//  ListBuildsTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListBuildsTests: XCTestCase {
    // MARK: - Fields
    func test_field_appEncryptionDeclarations() {
        let endpoint = APIEndpoint.builds(
            fields: [.appEncryptionDeclarations(ListBuilds.Field.AppEncryptionDeclaration.allCases)],
            filter: nil,
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?fields%5BappEncryptionDeclarations%5D=app%2CappEncryptionDeclarationState%2CavailableOnFrenchStore%2Cbuilds%2CcodeValue%2CcontainsProprietaryCryptography%2CcontainsThirdPartyCryptography%2CdocumentName%2CdocumentType%2CdocumentUrl%2Cexempt%2Cplatform%2CuploadedDate%2CusesEncryption"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_field_appStoreVersions() {
        let endpoint = APIEndpoint.builds(
            fields: [.appStoreVersions(ListBuilds.Field.AppStoreVersion.allCases)],
            filter: nil,
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?fields%5BappStoreVersions%5D=ageRatingDeclaration%2Capp%2CappStoreReviewDetail%2CappStoreState%2CappStoreVersionLocalizations%2CappStoreVersionPhasedRelease%2CappStoreVersionSubmission%2Cbuild%2Ccopyright%2CcreatedDate%2Cdownloadable%2CearliestReleaseDate%2CidfaDeclaration%2Cplatform%2CreleaseType%2CroutingAppCoverage%2CusesIdfa%2CversionString"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_field_apps() {
        let endpoint = APIEndpoint.builds(
            fields: [.apps(ListBuilds.Field.App.allCases)],
            filter: nil,
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?fields%5Bapps%5D=appInfos%2CappStoreVersions%2CavailableInNewTerritories%2CavailableTerritories%2CbetaAppLocalizations%2CbetaAppReviewDetail%2CbetaGroups%2CbetaLicenseAgreement%2CbetaTesters%2Cbuilds%2CbundleId%2CcontentRightsDeclaration%2CendUserLicenseAgreement%2CgameCenterEnabledVersions%2CinAppPurchases%2CisOrEverWasMadeForKids%2Cname%2CperfPowerMetrics%2CpreOrder%2CpreReleaseVersions%2Cprices%2CprimaryLocale%2Csku"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_field_betaAppReviewSubmissions() {
        let endpoint = APIEndpoint.builds(
            fields: [.betaAppReviewSubmissions(ListBuilds.Field.BetaAppReviewSubmission.allCases)],
            filter: nil,
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?fields%5BbetaAppReviewSubmissions%5D=betaReviewState%2Cbuild"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_field_betaBuildLocalizations() {
        let endpoint = APIEndpoint.builds(
            fields: [.betaBuildLocalizations(ListBuilds.Field.BetaBuildLocalization.allCases)],
            filter: nil,
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?fields%5BbetaBuildLocalizations%5D=build%2Clocale%2CwhatsNew"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_field_betaTesters() {
        let endpoint = APIEndpoint.builds(
            fields: [.betaTesters(ListBuilds.Field.BetaTester.allCases)],
            filter: nil,
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?fields%5BbetaTesters%5D=apps%2CbetaGroups%2Cbuilds%2Cemail%2CfirstName%2CinviteType%2ClastName"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_field_buildBetaDetails() {
        let endpoint = APIEndpoint.builds(
            fields: [.buildBetaDetails(ListBuilds.Field.BuildBetaDetail.allCases)],
            filter: nil,
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?fields%5BbuildBetaDetails%5D=autoNotifyEnabled%2Cbuild%2CexternalBuildState%2CinternalBuildState"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_field_buildIcons() {
        let endpoint = APIEndpoint.builds(
            fields: [.buildIcons(ListBuilds.Field.BuildIcon.allCases)],
            filter: nil,
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?fields%5BbuildIcons%5D=iconAsset%2CiconType"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_field_builds() {
        let endpoint = APIEndpoint.builds(
            fields: [.builds(ListBuilds.Field.Build.allCases)],
            filter: nil,
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?fields%5Bbuilds%5D=app%2CappEncryptionDeclaration%2CappStoreVersion%2CbetaAppReviewSubmission%2CbetaBuildLocalizations%2CbetaGroups%2CbuildBetaDetail%2CdiagnosticSignatures%2CexpirationDate%2Cexpired%2CiconAssetToken%2Cicons%2CindividualTesters%2CminOsVersion%2CperfPowerMetrics%2CpreReleaseVersion%2CprocessingState%2CuploadedDate%2CusesNonExemptEncryption%2Cversion"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_field_diagnosticSignatures() {
        let endpoint = APIEndpoint.builds(
            fields: [.diagnosticSignatures(ListBuilds.Field.DiagnosticSignature.allCases)],
            filter: nil,
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?fields%5BdiagnosticSignatures%5D=diagnosticType%2Clogs%2Csignature%2Cweight"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_field_perfPowerMetrics() {
        let endpoint = APIEndpoint.builds(
            fields: [.perfPowerMetrics(ListBuilds.Field.PerfPowerMetric.allCases)],
            filter: nil,
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?fields%5BperfPowerMetrics%5D=deviceType%2CmetricType%2Cplatform"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_field_preReleaseVersions() {
        let endpoint = APIEndpoint.builds(
            fields: [.preReleaseVersions(ListBuilds.Field.PreReleaseVersion.allCases)],
            filter: nil,
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?fields%5BpreReleaseVersions%5D=app%2Cbuilds%2Cplatform%2Cversion"
        XCTAssertEqual(absoluteString, expected)
    }

    func xtestURLRequest() {
        let endpoint = APIEndpoint.builds(
            fields: [
                .appEncryptionDeclarations(ListBuilds.Field.AppEncryptionDeclaration.allCases),
                .apps(ListBuilds.Field.App.allCases),
                .betaAppReviewSubmissions(ListBuilds.Field.BetaAppReviewSubmission.allCases),
                .betaBuildLocalizations(ListBuilds.Field.BetaBuildLocalization.allCases),
                .betaTesters(ListBuilds.Field.BetaTester.allCases),
                .buildBetaDetails(ListBuilds.Field.BuildBetaDetail.allCases),
                .builds(ListBuilds.Field.Build.allCases),
                .preReleaseVersions(ListBuilds.Field.PreReleaseVersion.allCases)],
            filter: [
                .app(["app"]),
                .appStoreVersion(["1.2.3"]),
                .betaAppReviewSubmissionBetaReviewState(["betaAppReviewSubmissionBetaReviewState"]),
                .betaGroups(["betaGroups"]),
                .expired(["expired"]),
                .id(["id"]),
                .preReleaseVersion(["preReleaseVersion"]),
                .preReleaseVersionVersion(["preReleaseVersionVersion"]),
                .processingState(ListBuilds.Filter.ProcessingState.allCases),
                .usesNonExemptEncryption(["usesNonExemptEncryption"]),
                .version(["version"])],
            include: ListBuilds.Include.allCases,
            limit: [
                ListBuilds.Limit.betaBuildLocalizations(1),
                ListBuilds.Limit.individualTesters(2)],
            sort: ListBuilds.Sort.allCases,
            next: .test)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?cursor=NEXT&fields%5BAppEncryptionDeclaration%5D=app%2CappEncryptionDeclarationState%2CavailableOnFrenchStore%2Cbuilds%2CcodeValue%2CcontainsProprietaryCryptography%2CcontainsThirdPartyCryptography%2CdocumentName%2CdocumentType%2CdocumentUrl%2Cexempt%2Cplatform%2CuploadedDate%2CusesEncryption&fields%5Bapps%5D=betaAppLocalizations%2CbetaAppReviewDetail%2CbetaGroups%2CbetaLicenseAgreement%2CbetaTesters%2Cbuilds%2CbundleId%2Cname%2CpreReleaseVersions%2CprimaryLocale%2Csku&fields%5BbetaAppReviewSubmission%5D=betaReviewState%2Cbuild&fields%5BbetaBuildLocalization%5D=build%2Clocale%2CwhatsNew&fields%5BbetaTester%5D=apps%2CbetaGroups%2Cbuilds%2Cemail%2CfirstName%2CinviteType%2ClastName&fields%5BbuildBetaDetail%5D=autoNotifyEnabled%2Cbuild%2CexternalBuildState%2CinternalBuildState&fields%5Bbuilds%5D=app%2CappEncryptionDeclaration%2CappStoreVersion%2CbetaAppReviewSubmission%2CbetaBuildLocalizations%2CbetaGroups%2CbuildBetaDetail%2CexpirationDate%2Cexpired%2CiconAssetToken%2CindividualTesters%2CminOsVersion%2CpreReleaseVersion%2CprocessingState%2CuploadedDate%2CusesNonExemptEncryption%2Cversion&fields%5BpreReleaseVersions%5D=app%2Cbuilds%2Cplatform%2Cversion&filter%5BappStoreVersion%5D=1.2.3&filter%5Bapp%5D=app&filter%5BbetaAppReviewSubmission.betaReviewState%5D=betaAppReviewSubmissionBetaReviewState&filter%5Bbetagroup%5D=betaGroups&filter%5Bexpired%5D=expired&filter%5Bid%5D=id&filter%5BpreReleaseVersion.version%5D=preReleaseVersionVersion&filter%5BpreReleaseVersion%5D=preReleaseVersion&filter%5BprocessingState%5D=PROCESSING%2CFAILED%2CINVALID%2CVALID&filter%5BusesNonExemptEncryption%5D=usesNonExemptEncryption&filter%5Bversion%5D=version&include=app%2CappEncryptionDeclaration%2CbetaAppReviewSubmission%2CbetaBuildLocalizations%2CbuildBetaDetail%2CindividualTesters%2CpreReleaseVersion&limit%5BbetaBuildLocalizations%5D=1&limit%5BindividualTesters%5D=2&sort=%2BpreReleaseVersion%2C-preReleaseVersion%2C%2BuploadedDate%2C-uploadedDate%2C%2Bversion%2C-version"
        XCTAssertEqual(absoluteString, expected)
    }
}
