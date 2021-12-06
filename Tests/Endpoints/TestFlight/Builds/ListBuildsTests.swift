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

    // MARK: - Filters

    func test_filter_app() {
        let endpoint = APIEndpoint.builds(
            fields: nil,
            filter: [.app(["app"])],
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?filter%5Bapp%5D=app"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_filter_appStoreVersion() {
        let endpoint = APIEndpoint.builds(
            fields: nil,
            filter: [.appStoreVersion(["appStoreVersion"])],
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?filter%5BappStoreVersion%5D=appStoreVersion"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_filter_betaAppReviewSubmissionBetaReviewState() {
        let endpoint = APIEndpoint.builds(
            fields: nil,
            filter: [.betaAppReviewSubmissionBetaReviewState(["betaAppReviewSubmissionBetaReviewState"])],
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?filter%5BbetaAppReviewSubmission.betaReviewState%5D=betaAppReviewSubmissionBetaReviewState"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_filter_betaGroups() {
        let endpoint = APIEndpoint.builds(
            fields: nil,
            filter: [.betaGroups(["betaGroups"])],
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?filter%5Bbetagroup%5D=betaGroups"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_filter_expired() {
        let endpoint = APIEndpoint.builds(
            fields: nil,
            filter: [.expired(["expired"])],
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?filter%5Bexpired%5D=expired"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_filter_id() {
        let endpoint = APIEndpoint.builds(
            fields: nil,
            filter: [.id(["id"])],
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?filter%5Bid%5D=id"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_filter_preReleaseVersion() {
        let endpoint = APIEndpoint.builds(
            fields: nil,
            filter: [.preReleaseVersion(["preReleaseVersion"])],
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?filter%5BpreReleaseVersion%5D=preReleaseVersion"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_filter_preReleaseVersionVersion() {
        let endpoint = APIEndpoint.builds(
            fields: nil,
            filter: [.preReleaseVersionVersion(["preReleaseVersionVersion"])],
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?filter%5BpreReleaseVersion.version%5D=preReleaseVersionVersion"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_filter_preReleaseVersionPlatform() {
        let endpoint = APIEndpoint.builds(
            fields: nil,
            filter: [.preReleaseVersionPlatform(ListBuilds.Filter.PreReleaseVersionPlatform.allCases)],
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?filter%5BpreReleaseVersion.platform%5D=IOS%2CMAC_OS%2CTV_OS"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_filter_processingState() {
        let endpoint = APIEndpoint.builds(
            fields: nil,
            filter: [.processingState(ListBuilds.Filter.ProcessingState.allCases)],
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?filter%5BprocessingState%5D=PROCESSING%2CFAILED%2CINVALID%2CVALID"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_filter_usesNonExemptEncryption() {
        let endpoint = APIEndpoint.builds(
            fields: nil,
            filter: [.usesNonExemptEncryption(["usesNonExemptEncryption"])],
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?filter%5BusesNonExemptEncryption%5D=usesNonExemptEncryption"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_filter_version() {
        let endpoint = APIEndpoint.builds(
            fields: nil,
            filter: [.version(["version"])],
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?filter%5Bversion%5D=version"
        XCTAssertEqual(absoluteString, expected)
    }

    // MARK: - Include

    func test_include_all() {
        let endpoint = APIEndpoint.builds(
            fields: nil,
            filter: nil,
            include: ListBuilds.Include.allCases,
            limit: nil,
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?include=app%2CappEncryptionDeclaration%2CappStoreVersion%2CbetaAppReviewSubmission%2CbetaBuildLocalizations%2CbuildBetaDetail%2CbuildBundles%2Cicons%2CindividualTesters%2CpreReleaseVersion"
        XCTAssertEqual(absoluteString, expected)
    }

    // MARK: - Limit

    func test_limit_betaBuildLocalizations() {
        let endpoint = APIEndpoint.builds(
            fields: nil,
            filter: nil,
            include: nil,
            limit: [.betaBuildLocalizations(5)],
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?limit%5BbetaBuildLocalizations%5D=5"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_limit_icons() {
        let endpoint = APIEndpoint.builds(
            fields: nil,
            filter: nil,
            include: nil,
            limit: [.icons(5)],
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?limit%5Bicons%5D=5"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_limit_individualTesters() {
        let endpoint = APIEndpoint.builds(
            fields: nil,
            filter: nil,
            include: nil,
            limit: [.individualTesters(5)],
            sort: nil,
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?limit%5BindividualTesters%5D=5"
        XCTAssertEqual(absoluteString, expected)
    }

    // MARK: - Sort

    func test_sort_preReleaseVersionAscending() {
        let endpoint = APIEndpoint.builds(
            fields: nil,
            filter: nil,
            include: nil,
            limit: nil,
            sort: [.preReleaseVersionAscending],
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?sort=%2BpreReleaseVersion"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_sort_preReleaseVersionDescending() {
        let endpoint = APIEndpoint.builds(
            fields: nil,
            filter: nil,
            include: nil,
            limit: nil,
            sort: [.preReleaseVersionDescending],
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?sort=-preReleaseVersion"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_sort_uploadedDateAscending() {
        let endpoint = APIEndpoint.builds(
            fields: nil,
            filter: nil,
            include: nil,
            limit: nil,
            sort: [.uploadedDateAscending],
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?sort=%2BuploadedDate"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_sort_uploadedDateDescending() {
        let endpoint = APIEndpoint.builds(
            fields: nil,
            filter: nil,
            include: nil,
            limit: nil,
            sort: [.uploadedDateDescending],
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?sort=-uploadedDate"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_sort_versionAscending() {
        let endpoint = APIEndpoint.builds(
            fields: nil,
            filter: nil,
            include: nil,
            limit: nil,
            sort: [.versionAscending],
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?sort=%2Bversion"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_sort_versionDescending() {
        let endpoint = APIEndpoint.builds(
            fields: nil,
            filter: nil,
            include: nil,
            limit: nil,
            sort: [.versionDescending],
            next: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?sort=-version"
        XCTAssertEqual(absoluteString, expected)
    }

    // MARK: - Combined

    func test_combined() {
        let endpoint = APIEndpoint.builds(
            fields: [.appEncryptionDeclarations(ListBuilds.Field.AppEncryptionDeclaration.allCases)],
            filter: [.app(["app"])],
            include: [.app],
            limit: [.betaBuildLocalizations(1)],
            sort: [.preReleaseVersionAscending],
            next: .test)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds?cursor=NEXT&fields%5BappEncryptionDeclarations%5D=app%2CappEncryptionDeclarationState%2CavailableOnFrenchStore%2Cbuilds%2CcodeValue%2CcontainsProprietaryCryptography%2CcontainsThirdPartyCryptography%2CdocumentName%2CdocumentType%2CdocumentUrl%2Cexempt%2Cplatform%2CuploadedDate%2CusesEncryption&filter%5Bapp%5D=app&include=app&limit%5BbetaBuildLocalizations%5D=1&sort=%2BpreReleaseVersion"
        XCTAssertEqual(absoluteString, expected)
    }
}
