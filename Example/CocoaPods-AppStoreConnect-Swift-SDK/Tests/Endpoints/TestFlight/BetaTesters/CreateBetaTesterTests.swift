//
//  CreateBetaTesterTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 26/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class CreateBetaTesterTests: XCTestCase {
    
    func testURLRequest() {
        let createRequest = BetaTesterCreateRequest(data: .init(
            attributes: .init(email: "email", firstName: "firstName", lastName: "lastName"),
            relationships: nil,
            type: ""))
        
        let endpoint = APIEndpoint.create(betaTester: createRequest)
        
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "POST")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaTesters"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(createRequest))
    }
}
