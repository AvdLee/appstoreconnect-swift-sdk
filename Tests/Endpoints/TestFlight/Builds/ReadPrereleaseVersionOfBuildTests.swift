//
//  ReadPrereleaseVersionOfBuildTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ReadPrereleaseVersionOfBuildTests: XCTestCase {

    func testURLRequest() {
        let endpoint = APIEndpoint.prereleaseVersion(
            ofBuildWithId: "id",
            fields: [.preReleaseVersions(ReadPrereleaseVersionOfBuild.Field.PreReleaseVersion.allCases)])
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds/id/preReleaseVersion?fields%5BpreReleaseVersion%5D=app%2Cbuilds%2Cplatform%2Cversion"
        XCTAssertEqual(absoluteString, expected)
    }
}
