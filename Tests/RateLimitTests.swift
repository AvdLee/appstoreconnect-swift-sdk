//
//  RateLimitTests.swift
//  
//
//  Created by Mathias Emil Mortensen on 05/04/2023.
//

@testable import AppStoreConnect_Swift_SDK
import XCTest
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class RateLimitTests: XCTestCase {

    func testValidValue() {
        let rateLimit = RateLimit(value: "user-hour-lim:3600;user-hour-rem:3545;", requestURL: nil)
        XCTAssertEqual(rateLimit.entries.count, 2)
        XCTAssertEqual(rateLimit.entries["user-hour-lim"], 3600)
        XCTAssertEqual(rateLimit.entries["user-hour-rem"], 3545)
    }

    func testInvalidValue() {
        let rateLimit = RateLimit(value: "user-hour-rem3545", requestURL: nil)
        XCTAssertEqual(rateLimit.entries.count, 0)
    }

    func testPartialInvalidValue() {
        let rateLimit = RateLimit(value: "user-hour-rem3545;user-hour-rem:3545;", requestURL: nil)
        XCTAssertEqual(rateLimit.entries.count, 1)
        XCTAssertEqual(rateLimit.entries["user-hour-rem"], 3545)
    }

    func testMoreItems() {
        let rateLimit = RateLimit(
            value: "user-hour-lim:3600;user-hour-rem:3598;user-minute-lim:150;user-minute-rem:149;",
            requestURL: nil)
        XCTAssertEqual(rateLimit.entries.count, 4)
        XCTAssertEqual(rateLimit.entries["user-hour-lim"], 3600)
        XCTAssertEqual(rateLimit.entries["user-hour-rem"], 3598)
        XCTAssertEqual(rateLimit.entries["user-minute-lim"], 150)
        XCTAssertEqual(rateLimit.entries["user-minute-rem"], 149)
    }

    func testMultipleHeaders() {
        let rateLimit = RateLimit(
            value: "user-hour-lim:3600;user-hour-rem:3598;, user-minute-lim:150;user-minute-rem:149;",
            requestURL: nil)
        XCTAssertEqual(rateLimit.entries.count, 4)
        XCTAssertEqual(rateLimit.entries["user-hour-lim"], 3600)
        XCTAssertEqual(rateLimit.entries["user-hour-rem"], 3598)
        XCTAssertEqual(rateLimit.entries["user-minute-lim"], 150)
        XCTAssertEqual(rateLimit.entries["user-minute-rem"], 149)
    }

    func testExtractingHeaderField() {
        let httpUrlResponse = HTTPURLResponse(url: URL(string: "https://api.appstoreconnect.apple.com/")!,
                                              statusCode: 200, httpVersion: nil,
                                              headerFields: ["X-ratE-limiT": "user-hour-lim:3600;user-hour-rem:3545;"])
        let rateLimit = httpUrlResponse?.rateLimit
        XCTAssertNotNil(rateLimit)
        if let rateLimit {
            XCTAssertEqual(rateLimit.entries.count, 2)
            XCTAssertEqual(rateLimit.entries["user-hour-lim"], 3600)
            XCTAssertEqual(rateLimit.entries["user-hour-rem"], 3545)
        }
    }
}
