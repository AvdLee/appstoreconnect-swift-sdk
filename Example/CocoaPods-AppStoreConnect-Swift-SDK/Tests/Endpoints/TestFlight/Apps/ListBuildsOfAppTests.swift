//
//  ListBuildsOfAppTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 26/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListBuildsOfAppTests: XCTestCase {
    
    let provider = APIProvider(configuration: APIConfiguration(issuerID: "", privateKeyID: "", privateKey: ""))
    
    func testAbsoluteString() {
        let endpoint = APIEndpoint.buildsOfApp(
            withId: "appId",
            fields: [.builds(ListBuildsOfApp.Field.Build.allCases)],
            limit: 1)
        let absoluteString = provider.request(for: endpoint).request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/apps/appId/builds?fields%5Bbuild%5D=app%2CappEncryptionDeclaration%2CbetaAppReviewSubmission%2CbetaBuildLocalizations%2CbetaGroups%2CbuildBetaDetail%2CexpirationDate%2Cexpired%2CiconAssetToken%2CindividualTesters%2CminOsVersion%2CpreReleaseVersion%2CprocessingState%2CuploadedDate%2CusesNonExemptEncryption%2Cversion&limit=1"
        XCTAssertEqual(absoluteString, expected)
    }
}
