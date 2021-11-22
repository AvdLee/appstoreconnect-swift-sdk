//
//  ListAppEncryptionDeclarationsTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListAppEncryptionDeclarationsTests: XCTestCase {

    func testURLRequest() {
        let endpoint = APIEndpoint.appEncryptionDeclarations(
            fields: [
                .apps(ListAppEncryptionDeclarations.Field.App.allCases),
                .appEncryptionDeclarations(ListAppEncryptionDeclarations.Field.AppEncryptionDeclaration.allCases)],
            filter: [
                .app(["app"]),
                .builds(["builds"]),
                .platform(["platform"])],
            include: ListAppEncryptionDeclarations.Include.allCases,
            limit: 2,
            next: .test)
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/appEncryptionDeclarations?cursor=NEXT&fields%5BappEncryptionDeclaration%5D=app%2CappEncryptionDeclarationState%2CavailableOnFrenchStore%2Cbuilds%2CcodeValue%2CcontainsProprietaryCryptography%2CcontainsThirdPartyCryptography%2CdocumentName%2CdocumentType%2CdocumentUrl%2Cexempt%2Cplatform%2CuploadedDate%2CusesEncryption&fields%5Bapp%5D=betaAppLocalizations%2CbetaAppReviewDetail%2CbetaGroups%2CbetaLicenseAgreement%2CbetaTesters%2Cbuilds%2CbundleId%2Cname%2CpreReleaseVersions%2CprimaryLocale%2Csku&filter%5Bapp%5D=app&filter%5Bbuilds%5D=builds&filter%5Bplatform%5D=platform&include=app&limit=2"
        XCTAssertEqual(absoluteString, expected)
    }
}
