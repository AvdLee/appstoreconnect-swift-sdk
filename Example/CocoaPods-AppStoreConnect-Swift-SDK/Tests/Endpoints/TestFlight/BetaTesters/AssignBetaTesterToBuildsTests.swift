//
//  AssignBetaTesterToBuildsTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 26/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class AssignBetaTesterToBuildsTests: XCTestCase {
    
    func testURLRequest() {
        let linkageRequest = BetaTesterBuildsLinkagesRequest(data: [
            BetaTesterBuildsLinkagesRequest.Data(id: "betaTesterId", type: "betatesters")])
        
        let endpoint = APIEndpoint.assign(
            betaTester: linkageRequest, toBuildWithId: "buildId")
        
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "POST")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaTesters/buildId/relationships/builds"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(linkageRequest))
    }
}
