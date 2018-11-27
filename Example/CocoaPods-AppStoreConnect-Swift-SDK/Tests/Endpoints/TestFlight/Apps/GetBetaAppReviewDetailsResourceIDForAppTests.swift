//
//  GetBetaAppReviewDetailsResourceIDForAppTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 26/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class GetBetaAppReviewDetailsResourceIDForAppTests: XCTestCase {
    
    let provider = APIProvider(configuration: APIConfiguration(issuerID: "", privateKeyID: "", privateKey: ""))
    
    func testAbsoluteString() {
        let endpoint = APIEndpoint<AppBetaAppReviewDetailLinkageResponse>.betaAppReviewDetailsResourceIDForApp(withId: "appId")
        let absoluteString = provider.request(for: endpoint).request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/apps/appId/relationships/betaAppReviewDetail"
        XCTAssertEqual(absoluteString, expected)
    }
}
