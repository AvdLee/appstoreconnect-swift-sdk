//
//  ProfilesResponseTests.swift
//  AppStoreConnect-Swift-SDKTests
//
//  Created by Oliver Jones on 17/4/20.
//

@testable import AppStoreConnect_Swift_SDK
import XCTest
import Foundation

class ProfilesResponseTests: XCTestCase {

    let decoder = APIProvider.jsonDecoder

    private func decodeFixture(named: String) throws {
        let fixture = try Fixture(named: named)
        _ = try decoder.decode(ProfilesResponse.self, from: fixture.data)
    }

    func testDecodeEmpty() throws {
        try decodeFixture(named: "v1/profiles/empty")
    }

    func testDecodeNonEmpty() throws {
        try decodeFixture(named: "v1/profiles/non_empty")
    }

    func testDecodeIncludeBundleId() throws {
        try decodeFixture(named: "v1/profiles/include_bundleId")
    }

    func testDecodeIncludeCertificates() throws {
        try decodeFixture(named: "v1/profiles/include_certificates")
    }

    func testDecodeIncludeDevices() throws {
        try decodeFixture(named: "v1/profiles/include_devices")
    }
}
