//
//  ListBuildBetaDetailsTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListBuildBetaDetailsTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.buildBetaDetails(
            ofBuildWithId: "id",
            fields: [.buildBetaDetails(ReadBuildBetaDetailsInformationOfBuild.Field.BuildBetaDetail.allCases)])
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds/id/buildBetaDetail?fields%5BbuildBetaDetail%5D=autoNotifyEnabled%2Cbuild%2CexternalBuildState%2CinternalBuildState"
        XCTAssertEqual(absoluteString, expected)
    }
}
