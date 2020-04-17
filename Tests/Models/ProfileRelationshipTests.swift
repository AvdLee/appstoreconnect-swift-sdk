//
//  ProfileRelationshipTests.swift
//  AppStoreConnect-Swift-SDKTests
//
//  Created by Oliver Jones on 17/4/20.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ProfileRelationshipTests: XCTestCase {

    func testEncoding() throws {
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()

        // Errors
        XCTAssertThrowsError((try decoder.decode(ProfileRelationship.self, from: "{}".data(using: .utf8)!)))
        XCTAssertThrowsError(try decoder.decode(ProfileRelationship.self, from: "{\"type\": 2}".data(using: .utf8)!))
        XCTAssertThrowsError(try decoder.decode(ProfileRelationship.self, from: "{\"type\": \"error\"}".data(using: .utf8)!))
        XCTAssertThrowsError(try decoder.decode(ProfileRelationship.self, from: "{\"type\": \"devices\"}".data(using: .utf8)!))

        let allCases = [
            ProfileRelationship.device(.test),
            ProfileRelationship.bundleId(.test),
            ProfileRelationship.certificate(.test),
        ]
        for relationship in allCases {
            let encoded = try encoder.encode(relationship)
            XCTAssertNotNil(encoded)

            let decoded = try? decoder.decode(ProfileRelationship.self, from: encoded)
            XCTAssertNotNil(decoded)
        }
    }
}

