//
//  GetResourceIDsOfPrereleaseVersionsForBuildTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class GetResourceIDsOfPrereleaseVersionsForBuildTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.prereleaseVersionIDs(ofForBuildWithId: "id")
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds/id/relationships/preReleaseVersion"
        XCTAssertEqual(absoluteString, expected)
    }
}
