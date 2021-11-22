//
//  ModifyBetaAppReviewDetailTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ModifyBetaAppReviewDetailTests: XCTestCase {

    func testURLRequest() {
        let betaAppReviewDetailId = "id"
        let contactEmail = "contactEmail"
        let contactFirstName = "contactFirstName"
        let contactLastName = "contactLastName"
        let contactPhone = "contactPhone"
        let demoAccountName = "demoAccountName"
        let demoAccountPassword = "demoAccountPassword"
        let demoAccountRequired = true
        let notes = "notes"

        let endpoint = APIEndpoint.modify(
            betaAppReviewDetailWithId: betaAppReviewDetailId,
            contactEmail: contactEmail,
            contactFirstName: contactFirstName,
            contactLastName: contactLastName,
            contactPhone: contactPhone,
            demoAccountName: demoAccountName,
            demoAccountPassword: demoAccountPassword,
            demoAccountRequired: demoAccountRequired,
            notes: notes)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "PATCH")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/betaAppReviewDetails/id"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(BetaAppReviewDetailUpdateRequest(
            id: betaAppReviewDetailId,
            contactEmail: contactEmail,
            contactFirstName: contactFirstName,
            contactLastName: contactLastName,
            contactPhone: contactPhone,
            demoAccountName: demoAccountName,
            demoAccountPassword: demoAccountPassword,
            demoAccountRequired: demoAccountRequired,
            notes: notes)))
    }
}
