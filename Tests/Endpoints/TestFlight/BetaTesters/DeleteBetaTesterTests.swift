//
//  DeleteBetaTesterTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 26/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class DeleteBetaTesterTests: XCTestCase {

    func testURLRequest() {
        let endpoint = APIEndpoint.delete(betaTesterWithId: "betaTesterId")

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "DELETE")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaTesters/betaTesterId"
        XCTAssertEqual(absoluteString, expected)
    }
}
