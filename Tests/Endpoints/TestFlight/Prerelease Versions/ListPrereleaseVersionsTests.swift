//
//  ListPrereleaseVersionsTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListPrereleaseVersionsTests: XCTestCase {

    // MARK: - Fields

    func test_field_apps() {
        let endpoint = APIEndpoint.prereleaseVersions(
            fields: [.apps(ListPrereleaseVersions.Field.App.allCases)],
            filter: nil,
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/preReleaseVersions?fields%5Bapps%5D=appInfos%2CappStoreVersions%2CavailableInNewTerritories%2CavailableTerritories%2CbetaAppLocalizations%2CbetaAppReviewDetail%2CbetaGroups%2CbetaLicenseAgreement%2CbetaTesters%2Cbuilds%2CbundleId%2CcontentRightsDeclaration%2CendUserLicenseAgreement%2CgameCenterEnabledVersions%2CinAppPurchases%2CisOrEverWasMadeForKids%2Cname%2CperfPowerMetrics%2CpreOrder%2CpreReleaseVersions%2Cprices%2CprimaryLocale%2Csku"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_field_builds() {
        let endpoint = APIEndpoint.prereleaseVersions(
            fields: [.builds(ListPrereleaseVersions.Field.Build.allCases)],
            filter: nil,
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/preReleaseVersions?fields%5Bbuilds%5D=app%2CappEncryptionDeclaration%2CappStoreVersion%2CbetaAppReviewSubmission%2CbetaBuildLocalizations%2CbetaGroups%2CbuildBetaDetail%2CdiagnosticSignatures%2CexpirationDate%2Cexpired%2CiconAssetToken%2Cicons%2CindividualTesters%2CminOsVersion%2CperfPowerMetrics%2CpreReleaseVersion%2CprocessingState%2CuploadedDate%2CusesNonExemptEncryption%2Cversion"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_field_preReleaseVersions() {
        let endpoint = APIEndpoint.prereleaseVersions(
            fields: [.preReleaseVersions(ListPrereleaseVersions.Field.PreReleaseVersion.allCases)],
            filter: nil,
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/preReleaseVersions?fields%5BpreReleaseVersions%5D=app%2Cbuilds%2Cplatform%2Cversion"
        XCTAssertEqual(absoluteString, expected)
    }

    // MARK: - Filters

    func test_filter_app() {
        let endpoint = APIEndpoint.prereleaseVersions(
            fields: nil,
            filter: [.app(["123"])],
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/preReleaseVersions?filter%5Bapp%5D=123"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_filter_buildsExpired() {
        let endpoint = APIEndpoint.prereleaseVersions(
            fields: nil,
            filter: [.buildsExpired(["123"])],
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/preReleaseVersions?filter%5Bbuilds.expired%5D=123"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_filter_buildProcessingState() {
        let endpoint = APIEndpoint.prereleaseVersions(
            fields: nil,
            filter: [.buildsProcessingState(ListPrereleaseVersions.Filter.BuildsProcessingState.allCases)],
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/preReleaseVersions?filter%5Bbuilds.processingState%5D=PROCESSING%2CFAILED%2CINVALID%2CVALID"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_filter_builds() {
        let endpoint = APIEndpoint.prereleaseVersions(
            fields: nil,
            filter: [.builds(["123"])],
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/preReleaseVersions?filter%5Bbuilds%5D=123"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_filter_platform() {
        let endpoint = APIEndpoint.prereleaseVersions(
            fields: nil,
            filter: [.platform(ListPrereleaseVersions.Filter.Platform.allCases)],
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/preReleaseVersions?filter%5Bplatform%5D=IOS%2CMAC_OS%2CTV_OS"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_filter_version() {
        let endpoint = APIEndpoint.prereleaseVersions(
            fields: nil,
            filter: [.version(["123"])],
            include: nil,
            limit: nil,
            sort: nil,
            next: nil)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/preReleaseVersions?filter%5Bversion%5D=123"
        XCTAssertEqual(absoluteString, expected)
    }

    // MARK: - Includes

    func test_includes() {
        let endpoint = APIEndpoint.prereleaseVersions(
            fields: nil,
            filter: nil,
            include: [.app, .builds],
            limit: nil,
            sort: nil,
            next: nil)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/preReleaseVersions?include=app%2Cbuilds"
        XCTAssertEqual(absoluteString, expected)
    }

    // MARK: - Limits

    func test_limit_builds() {
        let endpoint = APIEndpoint.prereleaseVersions(
            fields: nil,
            filter: nil,
            include: nil,
            limit: [.builds(5)],
            sort: nil,
            next: nil)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/preReleaseVersions?limit%5Bbuilds%5D=5"
        XCTAssertEqual(absoluteString, expected)
    }

    // MARK: - Sorts

    func test_sort_versionAscending() {
        let endpoint = APIEndpoint.prereleaseVersions(
            fields: nil,
            filter: nil,
            include: nil,
            limit: nil,
            sort: [.versionAscending],
            next: nil)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/preReleaseVersions?sort=%2Bversion"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_sort_versionDescending() {
        let endpoint = APIEndpoint.prereleaseVersions(
            fields: nil,
            filter: nil,
            include: nil,
            limit: nil,
            sort: [.versionDescending],
            next: nil)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/preReleaseVersions?sort=-version"
        XCTAssertEqual(absoluteString, expected)
    }

    // MARK: - Combined

    func test_combined() {
        let endpoint = APIEndpoint.prereleaseVersions(
            fields: [.apps(ListPrereleaseVersions.Field.App.allCases)],
            filter: [.builds(["123"])],
            include: [.app, .builds],
            limit: [.builds(5)],
            sort: [.versionAscending],
            next: nil)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/preReleaseVersions?fields%5Bapps%5D=appInfos%2CappStoreVersions%2CavailableInNewTerritories%2CavailableTerritories%2CbetaAppLocalizations%2CbetaAppReviewDetail%2CbetaGroups%2CbetaLicenseAgreement%2CbetaTesters%2Cbuilds%2CbundleId%2CcontentRightsDeclaration%2CendUserLicenseAgreement%2CgameCenterEnabledVersions%2CinAppPurchases%2CisOrEverWasMadeForKids%2Cname%2CperfPowerMetrics%2CpreOrder%2CpreReleaseVersions%2Cprices%2CprimaryLocale%2Csku&filter%5Bbuilds%5D=123&include=app%2Cbuilds&limit%5Bbuilds%5D=5&sort=%2Bversion"
        XCTAssertEqual(absoluteString, expected)
    }
}
