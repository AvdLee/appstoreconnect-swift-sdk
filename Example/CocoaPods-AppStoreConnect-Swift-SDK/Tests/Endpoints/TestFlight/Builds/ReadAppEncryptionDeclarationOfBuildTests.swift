//
//  ReadAppEncryptionDeclarationOfBuildTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ReadAppEncryptionDeclarationOfBuildTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.appEncryptionDeclaration(
            ofBuildWithId: "buildId",
            fields: [.appEncryptionDeclarations(ReadAppEncryptionDeclarationOfBuild.Field.AppEncryptionDeclaration.allCases)])
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/builds/buildId/appEncryptionDeclaration?fields%5BAppEncryptionDeclaration%5D=app%2CappEncryptionDeclarationState%2CavailableOnFrenchStore%2Cbuilds%2CcodeValue%2CcontainsProprietaryCryptography%2CcontainsThirdPartyCryptography%2CdocumentName%2CdocumentType%2CdocumentUrl%2Cexempt%2Cplatform%2CuploadedDate%2CusesEncryption"
        XCTAssertEqual(absoluteString, expected)
    }
}
