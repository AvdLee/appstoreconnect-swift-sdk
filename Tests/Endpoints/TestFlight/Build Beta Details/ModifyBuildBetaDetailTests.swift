//
//  ModifyBuildBetaDetailTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ModifyBuildBetaDetailTests: XCTestCase {

    func testURLRequest() {
        let buildBetaDetailId = "id"
        let autoNotifyEnabled = true

        let endpoint = APIEndpoint.modify(
            buildBetaDetailWithId: buildBetaDetailId,
            autoNotifyEnabled: autoNotifyEnabled)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "PATCH")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/buildBetaDetails/id"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(BuildBetaDetailUpdateRequest(
            id: buildBetaDetailId,
            autoNotifyEnabled: autoNotifyEnabled)))
    }
}
