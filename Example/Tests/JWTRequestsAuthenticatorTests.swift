//
//  JWTRequestsAuthenticatorTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Antoine van der Lee on 10/11/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class JWTRequestsAuthenticatorTests: XCTestCase {

    private let configuration = APIConfiguration(issuerID: UUID().uuidString, privateKeyID: UUID().uuidString, privateKey: "MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgPaXyFvZfNydDEjxgjUCUxyGjXcQxiulEdGxoVbasV3GgCgYIKoZIzj0DAQehRANCAASflx/DU3TUWAoLmqE6hZL9A7i0DWpXtmIDCDiITRznC6K4/WjdIcuMcixy+m6O0IrffxJOablIX2VM8sHRscdr")
    private lazy var urlRequest = URLRequest(url: URL(string: "www.avanderlee.com")!)

    /// It should correctly set the authorization header.
    func testAuthorizationHeader() {
        let authenticator = JWTRequestsAuthenticator(apiConfiguration: configuration)
        let jwtCreator = MockJWTCreator(token: UUID().uuidString)
        authenticator.jwtCreator = jwtCreator
        let request = try! authenticator.adapt(urlRequest)
        XCTAssertTrue(request.allHTTPHeaderFields?["Authorization"] == "Bearer \(jwtCreator.token)")
    }

    /// It should return the cached bearer if it's not expired.
    func testCachedBearer() {
        let authenticator = JWTRequestsAuthenticator(apiConfiguration: configuration)
        let firstJWTCreator = MockJWTCreator(token: try! authenticator.jwtCreator.signedToken(using: configuration.privateKey))
        let secondJWTCreator = MockJWTCreator(token: UUID().uuidString)
        authenticator.jwtCreator = firstJWTCreator
        _ = try! authenticator.adapt(urlRequest)
        authenticator.jwtCreator = secondJWTCreator

        let request = try! authenticator.adapt(urlRequest)
        XCTAssertEqual(request.allHTTPHeaderFields!["Authorization"], "Bearer \(firstJWTCreator.token)")
    }

    /// It should return a new token if the cached token is expired.
    func testExpiredBearer() {
        let authenticator = JWTRequestsAuthenticator(apiConfiguration: configuration)
        let firstJWTCreator = JWT(keyIdentifier: configuration.privateKeyID, issuerIdentifier: configuration.issuerID, expireDuration: -10)
        let secondJWTCreator = MockJWTCreator(token: UUID().uuidString)

        authenticator.jwtCreator = firstJWTCreator
        _ = try! authenticator.adapt(urlRequest)
        authenticator.jwtCreator = secondJWTCreator

        let request = try! authenticator.adapt(urlRequest)
        XCTAssertEqual(request.allHTTPHeaderFields!["Authorization"], "Bearer \(secondJWTCreator.token)")
    }
}

private struct MockJWTCreator: JWTCreatable {

    let token: JWT.Token

    func signedToken(using privateKey: JWT.P8PrivateKey) throws -> JWT.Token {
        return token
    }
}
