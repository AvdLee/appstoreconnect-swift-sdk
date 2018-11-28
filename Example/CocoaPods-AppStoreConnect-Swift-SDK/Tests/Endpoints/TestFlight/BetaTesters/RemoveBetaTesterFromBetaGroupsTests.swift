//
//  RemoveBetaTesterFromBetaGroupsTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 26/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class RemoveBetaTesterFromBetaGroupsTests: XCTestCase {
    
    func testURLRequest() {
        let linkageRequest = BetaTesterBetaGroupsLinkagesRequest(data: [
            .init(id: "betaTesterId", type: "betatesters")])
        
        let endpoint = APIEndpoint.remove(
            betaTester: linkageRequest,
            fromBetaGroupWithId: "groupId")
        
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "DELETE")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaTesters/groupId/relationships/betaGroups"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(linkageRequest))
    }
}
