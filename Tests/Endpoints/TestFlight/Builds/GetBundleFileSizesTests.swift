//
//  GetBundleFileSizesTests.swift
//  AppStoreConnect-Swift-SDK-Tests
//
//  Created by Billy on 11/16/21.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class GetBundleFileSizesTests: XCTestCase {

    func testURLRequest() {
        let endpoint = APIEndpoint.buildBundleFileSizes(ofBundleWithId: "bundleId")
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/buildBundles/bundleId/buildBundleFileSizes"
        XCTAssertEqual(absoluteString, expected)
    }
}
