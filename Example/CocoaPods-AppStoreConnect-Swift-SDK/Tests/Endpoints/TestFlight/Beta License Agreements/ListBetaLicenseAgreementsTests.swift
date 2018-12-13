//
//  ListBetaLicenseAgreementsTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListBetaLicenseAgreementsTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.betaLicenseAgreements(
            fields: [
                .apps(ListBetaLicenseAgreements.Field.App.allCases),
                .betaLicenseAgreements(ListBetaLicenseAgreements.Field.BetaLicenseAgreement.allCases)],
            filter: [.app(["appId"])],
            include: ListBetaLicenseAgreements.Include.allCases,
            limit: 2,
            next: .test)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaLicenseAgreements?cursor=NEXT&fields%5BApp%5D=betaAppLocalizations%2CbetaAppReviewDetail%2CbetaGroups%2CbetaLicenseAgreement%2CbetaTesters%2Cbuilds%2CbundleId%2Cname%2CpreReleaseVersions%2CprimaryLocale%2Csku&fields%5BbetaLicenseAgreement%5D=agreementText%2Capp&filter%5Bapp%5D=appId&include=app&limit=2"
        XCTAssertEqual(absoluteString, expected)
    }
}
