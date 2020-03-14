//
//  AssignAppEncryptionDeclarationForBuildTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class AssignAppEncryptionDeclarationForBuildTests: XCTestCase {
    
    func testURLRequest() {
        let appEncryptionDeclarationId = "id"
        let buildId = "buildId"
        
        let endpoint = APIEndpoint.assign(
            appEncryptionDeclarationWithId: appEncryptionDeclarationId,
            toBuildWithId: buildId)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "PATCH")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds/buildId/relationships/appEncryptionDeclaration"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(request?.httpBody, try? JSONEncoder().encode(BuildAppEncryptionDeclarationLinkageRequest(appEncryptionDeclarationId)))
    }
}
