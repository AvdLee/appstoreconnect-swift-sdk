//
//  ModifyBetaLicenseAgreementTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ModifyBetaLicenseAgreementTests: XCTestCase {
    
    func testURLRequest() {
        let betaLicenseAgreementId = "id"
        let agreementText = "text"
        
        let endpoint = APIEndpoint.modify(
            betaLicenseAgreementWithId: "id",
            agreementText: "text")
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "PATCH")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaLicenseAgreements/id"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(BetaLicenseAgreementUpdateRequest(
            id: betaLicenseAgreementId,
            agreementText: agreementText)))
    }
}
