//
//  BuildRelationshipTests.swift
//  AppStoreConnect-Swift-SDKTests
//
//  Created by Pascal Edmond on 12/12/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class BuildRelationshipTests: XCTestCase {

    func test() {
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        
        // Errors
        XCTAssertThrowsError((try decoder.decode(BuildRelationship.self, from: "{}".data(using: .utf8)!)))
        XCTAssertThrowsError(try decoder.decode(BuildRelationship.self, from: "{\"type\": 2}".data(using: .utf8)!))
        XCTAssertThrowsError(try decoder.decode(BuildRelationship.self, from: "{\"type\": \"error\"}".data(using: .utf8)!))
        XCTAssertThrowsError(try decoder.decode(BuildRelationship.self, from: "{\"type\": \"betaGroups\"}".data(using: .utf8)!))
        
        let allCases = [
            BuildRelationship.app(.test),
            BuildRelationship.betaTester(.test),
            BuildRelationship.build(.test),
            BuildRelationship.betaAppReviewDetail(.test),
            BuildRelationship.buildBetaDetail(.test),
            BuildRelationship.preReleaseVersion(.test),
            BuildRelationship.betaAppReviewSubmission(.test)
        ]
        for relationship in allCases {
            let encoded = try? encoder.encode(relationship)
            XCTAssertNotNil(encoded)
            
            let decoded = try? decoder.decode(BuildRelationship.self, from: encoded ?? Data())
            XCTAssertNotNil(decoded)
        }
    }
}
