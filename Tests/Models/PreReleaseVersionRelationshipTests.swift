//
//  PreReleaseVersionRelationshipTests.swift
//  AppStoreConnect-Swift-SDKTests
//
//  Created by Pascal Edmond on 12/12/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class PreReleaseVersionRelationshipTests: XCTestCase {

    func test() {
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()

        // Errors
        XCTAssertThrowsError((try decoder.decode(PreReleaseVersionRelationship.self, from: "{}".data(using: .utf8)!)))
        XCTAssertThrowsError(try decoder.decode(PreReleaseVersionRelationship.self, from: "{\"type\": 2}".data(using: .utf8)!))
        XCTAssertThrowsError(try decoder.decode(PreReleaseVersionRelationship.self, from: "{\"type\": \"error\"}".data(using: .utf8)!))
        XCTAssertThrowsError(try decoder.decode(PreReleaseVersionRelationship.self, from: "{\"type\": \"betaGroups\"}".data(using: .utf8)!))

        let allCases = [
            PreReleaseVersionRelationship.app(.test),
            PreReleaseVersionRelationship.build(.test)
        ]
        for relationship in allCases {
            let encoded = try? encoder.encode(relationship)
            XCTAssertNotNil(encoded)

            let decoded = try? decoder.decode(PreReleaseVersionRelationship.self, from: encoded ?? Data())
            XCTAssertNotNil(decoded)
        }
    }
}
