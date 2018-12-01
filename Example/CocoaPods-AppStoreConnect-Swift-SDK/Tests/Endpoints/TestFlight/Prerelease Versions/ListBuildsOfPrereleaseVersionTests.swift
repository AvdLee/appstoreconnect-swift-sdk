//
//  ListBuildsOfPrereleaseVersionTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListBuildsOfPrereleaseVersionTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.builds(
            ofPrereleaseVersionWith: "id",
            fields: [.builds(ListBuildsOfPrereleaseVersion.Field.Build.allCases)],
            limit: 2)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/preReleaseVersions/id/builds?fields%5Bbuild%5D=app%2CappEncryptionDeclaration%2CbetaAppReviewSubmission%2CbetaBuildLocalizations%2CbetaGroups%2CbuildBetaDetail%2CexpirationDate%2Cexpired%2CiconAssetToken%2CindividualTesters%2CminOsVersion%2CpreReleaseVersion%2CprocessingState%2CuploadedDate%2CusesNonExemptEncryption%2Cversion&limit=2"
        XCTAssertEqual(absoluteString, expected)
    }
}
