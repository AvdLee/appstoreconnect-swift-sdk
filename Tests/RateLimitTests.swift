//
//  RateLimitTests.swift
//  
//
//  Created by Mathias Emil Mortensen on 05/04/2023.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class RateLimitTests: XCTestCase {

    func testValidValue() {
        let rateLimit = RateLimit(value: "user-hour-lim:3600;user-hour-rem:3545;", requestURL: nil)
        XCTAssertNotNil(rateLimit)
        if let rateLimit {
            XCTAssertEqual(rateLimit.hourlyLimit, 3600)
            XCTAssertEqual(rateLimit.remainingInCurrentHour, 3545)
        }
    }
    
    func testInvalidValue() {
        let rateLimit = RateLimit(value: "user-hour-rem:3545", requestURL: nil)
        XCTAssertNil(rateLimit)
    }
    
    func testModifiedValue() {
        let rateLimit = RateLimit(value: "user-hour-rem:0;user-hour-lim:50;user-hour-new-value:10;", requestURL: nil)
        XCTAssertNotNil(rateLimit)
        if let rateLimit {
            XCTAssertEqual(rateLimit.hourlyLimit, 50)
            XCTAssertEqual(rateLimit.remainingInCurrentHour, 0)
        }
    }
}
