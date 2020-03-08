//
//  ModifyBuildTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ModifyBuildTests: XCTestCase {
    
    func testURLRequest() {
        let buildId = "buildId"
        let appEncryptionDeclarationId = "appEncryptionDeclarationId"
        let expired = false
        let usesNonExemptEncryption = true
        
        let endpoint = APIEndpoint.modify(
            buildWithId: buildId,
            appEncryptionDeclarationId: appEncryptionDeclarationId,
            expired: expired,
            usesNonExemptEncryption: usesNonExemptEncryption)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "PATCH")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds/buildId"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(BuildUpdateRequest(
            id: buildId,
            expired: expired,
            appEncryptionDeclarationId: appEncryptionDeclarationId,
            usesNonExemptEncryption: usesNonExemptEncryption)))
    }
}
