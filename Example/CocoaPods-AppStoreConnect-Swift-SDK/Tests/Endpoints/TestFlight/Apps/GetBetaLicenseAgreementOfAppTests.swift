//
//  GetBetaLicenseAgreementOfAppTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 26/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class GetBetaLicenseAgreementOfAppTests: XCTestCase {
    
    let provider = APIProvider(configuration: APIConfiguration(issuerID: "", privateKeyID: "", privateKey: ""))
    
    func testAbsoluteString() {
        let endpoint = APIEndpoint<BetaLicenseAgreementResponse>.betaLicenseAgreementOfApp(
            withId: "appId",
            fields: [.betaLicenseAgreements(GetBetaLicenseAgreementForApp.Field.BetaLicenseAgreement.allCases)])
        let absoluteString = provider.request(for: endpoint).request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/apps/appId/betaLicenseAgreement?fields%5BbetaLicenseAgreement%5D=agreementText%2Capp"
        XCTAssertEqual(absoluteString, expected)
    }
}
