//
//  ReadBetaAppReviewSubmissionOfBuildTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ReadBetaAppReviewSubmissionOfBuildTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.betaAppReviewSubmission(
            ofBuildWithId: "id",
            fields: [.betaAppReviewSubmissions(ReadBetaAppReviewSubmissionOfBuild.Field.BetaAppReviewSubmission.allCases)])
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds/id/betaAppReviewSubmission?fields%5BbetaAppReviewSubmission%5D=betaReviewState%2Cbuild"

        XCTAssertEqual(absoluteString, expected)
    }
}
