//
//  APIConfigurationTests.swift
//  
//
//  Created by Maxime Junger on 03/03/2023.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class APIConfigurationTests: XCTestCase {

    let issuerID = "1000A0B5-E42D-4A0A-ACD8-9B35B7AC0DB2"
    let privateKeyID = "941C4473-70BF-488F-A1C6-6A3F81337D0D"
    // swiftlint:disable:next line_length
    let privateKey = "MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgPaXyFvZfNydDEjxgjUCUxyGjXcQxiulEdGxoVbasV3GgCgYIKoZIzj0DAQehRANCAASflx/DU3TUWAoLmqE6hZL9A7i0DWpXtmIDCDiITRznC6K4/WjdIcuMcixy+m6O0IrffxJOablIX2VM8sHRscdr"


    func testValidPrivateKey() throws {
        XCTAssertNoThrow(try APIConfiguration(issuerID: issuerID,
                                              privateKeyID: privateKeyID,
                                              privateKey: privateKey))
    }

    func testNonBase64PrivateKey() throws {
        let nonBase64Key = "&^&%^$%$%"
        XCTAssertThrowsError(try APIConfiguration(issuerID: issuerID,
                                                  privateKeyID: privateKeyID,
                                                  privateKey: nonBase64Key)) { error in
            XCTAssertEqual(error as! JWT.Error, JWT.Error.invalidBase64EncodedPrivateKey)
        }
    }

    func testInvalidPrivateKey() throws {
        let invalidKey = "QSBrZXk=" // "A key"
        XCTAssertThrowsError(try APIConfiguration(issuerID: issuerID,
                                                  privateKeyID: privateKeyID,
                                                  privateKey: invalidKey)) { error in
            XCTAssertEqual(error as! JWT.Error, JWT.Error.invalidPrivateKey)
        }
    }

    func testInvalidExpirationDuration() throws {
        XCTAssertThrowsError(try APIConfiguration(issuerID: issuerID,
                                                  privateKeyID: privateKeyID,
                                                  privateKey: privateKey,
                                                  expirationDuration: 60 * 30)) { error in
            XCTAssertEqual(error as! JWT.Error, JWT.Error.invalidExpirationDuration)
        }
    }
}
