//
//  AppRelationshipTests.swift
//  AppStoreConnect-Swift-SDKTests
//
//  Created by Pascal Edmond on 12/12/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

class AppRelationshipTests: XCTestCase {

    func test() {
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        
        // Errors
        XCTAssertThrowsError((try decoder.decode(AppRelationship.self, from: "{}".data(using: .utf8)!)))
        XCTAssertThrowsError(try decoder.decode(AppRelationship.self, from: "{\"type\": 2}".data(using: .utf8)!))
        XCTAssertThrowsError(try decoder.decode(AppRelationship.self, from: "{\"type\": \"error\"}".data(using: .utf8)!))
        XCTAssertThrowsError(try decoder.decode(AppRelationship.self, from: "{\"type\": \"betaGroups\"}".data(using: .utf8)!))
        
        let allCases = [
            AppRelationship.betaGroup(.test),
            AppRelationship.prereleaseVersion(.test),
            AppRelationship.betaAppLocalization(.test),
            AppRelationship.build(.test),
            AppRelationship.betaLicenseAgreement(.test),
            AppRelationship.betaAppReviewDetail(.test)
        ]
        for relationship in allCases {
            let encoded = try? encoder.encode(relationship)
            XCTAssertNotNil(encoded)
            
            let decoded = try? decoder.decode(AppRelationship.self, from: encoded ?? Data())
            XCTAssertNotNil(decoded)
        }
    }
}
