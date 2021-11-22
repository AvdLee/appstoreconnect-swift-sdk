//
//  DeleteBetaAppLocalizationTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class DeleteBetaAppLocalizationTests: XCTestCase {

    func testURLRequest() {
        let endpoint = APIEndpoint.delete(betaAppLocalizationWithId: "id")
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "DELETE")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaAppLocalizations/id"
        XCTAssertEqual(absoluteString, expected)
    }
}
