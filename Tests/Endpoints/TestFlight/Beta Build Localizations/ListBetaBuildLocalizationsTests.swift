//
//  ListBetaBuildLocalizationsTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListBetaBuildLocalizationsTests: XCTestCase {

    func testURLRequest() {
        let endpoint = APIEndpoint.betaBuildLocalizations(
            fields: [
                .betaBuildLocalizations(ListBetaBuildLocalizations.Field.BetaBuildLocalization.allCases),
                .builds(ListBetaBuildLocalizations.Field.Build.allCases)],
            filter: [
                .build(["build"]),
                .locale(["locale"])],
            include: ListBetaBuildLocalizations.Include.allCases,
            limit: 2,
            next: .test)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaBuildLocalizations?cursor=NEXT&fields%5BbetaBuildLocalization%5D=build%2Clocale%2CwhatsNew&fields%5Bbuild%5D=app%2CappEncryptionDeclaration%2CbetaAppReviewSubmission%2CbetaBuildLocalizations%2CbetaGroups%2CbuildBetaDetail%2CexpirationDate%2Cexpired%2CiconAssetToken%2CindividualTesters%2CminOsVersion%2CpreReleaseVersion%2CprocessingState%2CuploadedDate%2CusesNonExemptEncryption%2Cversion&filter%5Bbuild%5D=build&filter%5Blocale%5D=locale&include=build&limit=2"
        XCTAssertEqual(absoluteString, expected)
    }
}
