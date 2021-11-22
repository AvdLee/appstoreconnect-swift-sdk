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
        let endpoint = APIEndpoint.betaAppReviewSubmissions(
            fields: [
                .betaAppReviewSubmissions(ListBetaAppReviewSubmissions.Field.BetaAppReviewSubmission.allCases),
                .builds(ListBetaAppReviewSubmissions.Field.Build.allCases)],
            filter: [
                .betaReviewState(["state"]),
                .build(["buildId"])],
            include: ListBetaAppReviewSubmissions.Include.allCases,
            limit: 2,
            next: .test)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaAppReviewSubmissions?cursor=NEXT&fields%5BbetaAppReviewSubmission%5D=betaReviewState%2Cbuild&fields%5Bbuild%5D=app%2CappEncryptionDeclaration%2CbetaAppReviewSubmission%2CbetaBuildLocalizations%2CbetaGroups%2CbuildBetaDetail%2CexpirationDate%2Cexpired%2CiconAssetToken%2CindividualTesters%2CminOsVersion%2CpreReleaseVersion%2CprocessingState%2CuploadedDate%2CusesNonExemptEncryption%2Cversion&filter%5BbetaReviewState%5D=state&filter%5Bbuild%5D=buildId&include=build&limit=2"
        XCTAssertEqual(absoluteString, expected)
    }
}
