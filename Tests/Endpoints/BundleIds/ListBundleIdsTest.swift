//
//  ListBundleIdsTest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Oliver Jones on 15/4/20.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListBundleIdsTests: XCTestCase {

    func testURLRequest() {
        let endpoint = APIEndpoint.listBundleIds(
            include: BundleIds.Include.allCases,
            sort: BundleIds.Sort.allCases,
            limit: 3,
            next: .test)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/bundleIds?cursor=NEXT&include=bundleIdCapabilities%2Cprofiles&limit=3&sort=%2Bid%2C-id%2C%2Bname%2C-name%2C%2Bplatform%2C-platform%2C%2BseedId%2C-seedId"

        XCTAssertEqual(absoluteString, expected)
    }
}
