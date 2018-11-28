//
//  GetBetaLicenseAgreementIDForAppTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 26/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class GetBetaLicenseAgreementIDForAppTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.betaLicenseAgreementIDForApp(withId: "appID")
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/apps/appID/relationships/betaLicenseAgreement"
        XCTAssertEqual(absoluteString, expected)
    }
}
