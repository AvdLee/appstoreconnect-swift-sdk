//
//  ReadBetaBuildLocalizationInformationTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ReadBetaBuildLocalizationInformationTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.betaBuildLocalization(
            withId: "id",
            fields: [
                .betaBuildLocalizations(ReadBetaBuildLocalizationInformation.Field.BetaBuildLocalization.allCases),
                .builds(ReadBetaBuildLocalizationInformation.Field.Build.allCases)],
            include: ReadBetaBuildLocalizationInformation.Include.allCases)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaBuildLocalizations/id?fields%5BbetaBuildLocalization%5D=build%2Clocale%2CwhatsNew&fields%5Bbuild%5D=app%2CappEncryptionDeclaration%2CbetaAppReviewSubmission%2CbetaBuildLocalizations%2CbetaGroups%2CbuildBetaDetail%2CexpirationDate%2Cexpired%2CiconAssetToken%2CindividualTesters%2CminOsVersion%2CpreReleaseVersion%2CprocessingState%2CuploadedDate%2CusesNonExemptEncryption%2Cversion&include=build"
        XCTAssertEqual(absoluteString, expected)
    }
}
