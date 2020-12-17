//
//  GetAppStoreVersionPhasedReleaseTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by James Sherlock on 14/12/2020.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class GetAppStoreVersionPhasedReleaseTests: XCTestCase {

    func testURLRequest() {
        let endpoint = APIEndpoint.appStoreVersionPhasedRelease(
            ofVersionWithId: "appId",
            fields: [
                .appStoreVersionPhasedReleases([
                    .currentDayNumber,
                    .phasedReleaseState,
                    .startDate,
                    .totalPauseDuration
                ])
            ]
        )
        
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
                
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/appStoreVersions/appId/appStoreVersionPhasedRelease?fields%5BappStoreVersionPhasedReleases%5D=currentDayNumber%2CphasedReleaseState%2CstartDate%2CtotalPauseDuration"
        XCTAssertEqual(absoluteString, expected)
    }
}
