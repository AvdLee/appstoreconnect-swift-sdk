//
//  SubmitAppForBetaReviewTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class SubmitAppForBetaReviewTests: XCTestCase {
    
    func testURLRequest() {
        let buildId = "buildId"
        let endpoint = APIEndpoint.submitAppForBetaReview(buildWithId: buildId)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "POST")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaAppReviewSubmissions"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(BetaAppReviewSubmissionCreateRequest(buildId: buildId)))
    }
}
