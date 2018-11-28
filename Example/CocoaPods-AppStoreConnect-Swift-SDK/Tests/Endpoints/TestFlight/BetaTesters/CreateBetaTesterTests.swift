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
        let email = "email"
        let firstName = "firstName"
        let lastName = "lastName"
        let betaGroupIds = ["betaGroupId"]
        let buildIds = ["buildId"]
        let endpoint = APIEndpoint.create(
            betaTesterWithEmail: email,
            firstName: firstName,
            lastName: lastName,
            betaGroupIds: betaGroupIds,
            buildIds: buildIds)
        
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "POST")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaTesters"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(BetaTesterCreateRequest(email: email, firstName: firstName, lastName: lastName, betaGroupIds: betaGroupIds, buildIds: buildIds)))
    }
}
