//
//  ReadBetaGroupInformationTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ReadBetaGroupInformationTests: XCTestCase {

    // MARK: - Fields

    func test_fields_apps() {
        let endpoint = APIEndpoint.betaGroup(
            withId: "betaGroupId",
            fields: [.apps(ReadBetaGroupInformation.Field.App.allCases)],
            include: nil,
            limit: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaGroups/betaGroupId?fields%5Bapps%5D=appInfos%2CappStoreVersions%2CavailableInNewTerritories%2CavailableTerritories%2CbetaAppLocalizations%2CbetaAppReviewDetail%2CbetaGroups%2CbetaLicenseAgreement%2CbetaTesters%2Cbuilds%2CbundleId%2CcontentRightsDeclaration%2CendUserLicenseAgreement%2CgameCenterEnabledVersions%2CinAppPurchases%2CisOrEverWasMadeForKids%2Cname%2CperfPowerMetrics%2CpreOrder%2CpreReleaseVersions%2Cprices%2CprimaryLocale%2Csku"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_fields_betaGroups() {
        let endpoint = APIEndpoint.betaGroup(
            withId: "betaGroupId",
            fields: [.betaGroups(ReadBetaGroupInformation.Field.BetaGroup.allCases)],
            include: nil,
            limit: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaGroups/betaGroupId?fields%5BbetaGroups%5D=app%2CbetaTesters%2Cbuilds%2CcreatedDate%2CfeedbackEnabled%2CisInternalGroup%2Cname%2CpublicLink%2CpublicLinkEnabled%2CpublicLinkId%2CpublicLinkLimit%2CpublicLinkLimitEnabled"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_fields_betaTesters() {
        let endpoint = APIEndpoint.betaGroup(
            withId: "betaGroupId",
            fields: [.betaTesters(ReadBetaGroupInformation.Field.BetaTester.allCases)],
            include: nil,
            limit: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaGroups/betaGroupId?fields%5BbetaTesters%5D=apps%2CbetaGroups%2Cbuilds%2Cemail%2CfirstName%2CinviteType%2ClastName"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_fields_builds() {
        let endpoint = APIEndpoint.betaGroup(
            withId: "betaGroupId",
            fields: [.builds(ReadBetaGroupInformation.Field.Build.allCases)],
            include: nil,
            limit: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaGroups/betaGroupId?fields%5Bbuilds%5D=app%2CappEncryptionDeclaration%2CappStoreVersion%2CbetaAppReviewSubmission%2CbetaBuildLocalizations%2CbetaGroups%2CbuildBetaDetail%2CdiagnosticSignatures%2CexpirationDate%2Cexpired%2CiconAssetToken%2Cicons%2CindividualTesters%2CminOsVersion%2CperfPowerMetrics%2CpreReleaseVersion%2CprocessingState%2CuploadedDate%2CusesNonExemptEncryption%2Cversion"
        XCTAssertEqual(absoluteString, expected)
    }

    // MARK: - Include

    func test_include_all() {
        let endpoint = APIEndpoint.betaGroup(
            withId: "betaGroupId",
            fields: nil,
            include: ReadBetaGroupInformation.Include.allCases,
            limit: nil)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaGroups/betaGroupId?include=app%2CbetaTesters%2Cbuilds"
        XCTAssertEqual(absoluteString, expected)
    }

    // MARK: - Limits

    func test_limit_builds() {
        let endpoint = APIEndpoint.betaGroup(
            withId: "betaGroupId",
            fields: nil,
            include: nil,
            limit: [.builds(5)])

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaGroups/betaGroupId?limit%5Bbuilds%5D=5"
        XCTAssertEqual(absoluteString, expected)
    }

    func test_limit_betaTesters() {
        let endpoint = APIEndpoint.betaGroup(
            withId: "betaGroupId",
            fields: nil,
            include: nil,
            limit: [.betaTesters(5)])

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaGroups/betaGroupId?limit%5BbetaTesters%5D=5"
        XCTAssertEqual(absoluteString, expected)
    }

    // MARK: - Combined

    func test_combined() {
        let endpoint = APIEndpoint.betaGroup(
            withId: "betaGroupId",
            fields: [.betaGroups([.betaTesters])],
            include: [.app],
            limit: [.builds(2), .betaTesters(5)])

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaGroups/betaGroupId?fields%5BbetaGroups%5D=betaTesters&include=app&limit%5BbetaTesters%5D=5&limit%5Bbuilds%5D=2"
        XCTAssertEqual(absoluteString, expected)
    }
}
