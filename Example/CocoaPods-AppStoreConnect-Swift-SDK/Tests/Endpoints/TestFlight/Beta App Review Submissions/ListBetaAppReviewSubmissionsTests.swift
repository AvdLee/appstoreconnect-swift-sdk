//
//  ListBetaAppReviewSubmissionsTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListBetaAppReviewSubmissionsTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.betaAppReviewDetail(
            withId: "id",
            fields: [
                .apps(ReadBetaAppReviewDetailInformation.Field.App.allCases),
                .betaAppReviewDetails(ReadBetaAppReviewDetailInformation.Field.BetaAppReviewDetail.allCases)],
            include: ReadBetaAppReviewDetailInformation.Include.allCases)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaAppReviewDetails/id?fields%5Bapp%5D=betaAppLocalizations%2CbetaAppReviewDetail%2CbetaGroups%2CbetaLicenseAgreement%2CbetaTesters%2Cbuilds%2CbundleId%2Cname%2CpreReleaseVersions%2CprimaryLocale%2Csku&fields%5BbetaAppReviewDetail%5D=app%2CcontactEmail%2CcontactFirstName%2CcontactLastName%2CcontactPhone%2CdemoAccountName%2CdemoAccountPassword%2CdemoAccountRequired%2Cnotes&include=app"
        XCTAssertEqual(absoluteString, expected)
    }
}
