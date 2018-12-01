//
//  ReadAppEncryptionDeclarationInformationTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ReadAppEncryptionDeclarationInformationTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.appEncryptionDeclaration(
            withId: "id",
            fields: [
                .apps(ReadAppEncryptionDeclarationInformation.Field.App.allCases),
                .appEncryptionDeclarations(ReadAppEncryptionDeclarationInformation.Field.AppEncryptionDeclaration.allCases)],
            include: ReadAppEncryptionDeclarationInformation.Include.allCases)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/appEncryptionDeclarations/id?fields%5BappEncryptionDeclaration%5D=app%2CappEncryptionDeclarationState%2CavailableOnFrenchStore%2Cbuilds%2CcodeValue%2CcontainsProprietaryCryptography%2CcontainsThirdPartyCryptography%2CdocumentName%2CdocumentType%2CdocumentUrl%2Cexempt%2Cplatform%2CuploadedDate%2CusesEncryption&fields%5Bapp%5D=betaAppLocalizations%2CbetaAppReviewDetail%2CbetaGroups%2CbetaLicenseAgreement%2CbetaTesters%2Cbuilds%2CbundleId%2Cname%2CpreReleaseVersions%2CprimaryLocale%2Csku&include=app"
        XCTAssertEqual(absoluteString, expected)
    }
}
