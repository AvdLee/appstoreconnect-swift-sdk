//
//  JWTAuthenticator.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Antoine van der Lee on 08/11/2018.
//

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

import Foundation

/// An Authenticator for URL Requests which makes use of the RequestAdapter from Alamofire.
final class JWTRequestsAuthenticator {

    private var cachedToken: JWT.Token?
    private let apiConfiguration: APIConfiguration

    /// The JWT Creator to use for creating the JWT token. Can be overriden for test use cases.
    var jwtCreator: JWTCreatable

    init(apiConfiguration: APIConfiguration) {
        self.apiConfiguration = apiConfiguration
        self.jwtCreator = JWT(keyIdentifier: apiConfiguration.privateKeyID, issuerIdentifier: apiConfiguration.issuerID, expireDuration: 60 * 20)
    }

    /// Generates a new JWT Token, but only if the in memory cached one is not expired.
    private func createToken() throws -> JWT.Token {
        if let cachedToken = cachedToken, !cachedToken.isExpired {
            return cachedToken
        }

        let token = try jwtCreator.signedToken(using: apiConfiguration.privateKey)
        cachedToken = token
        return token
    }
}

extension JWTRequestsAuthenticator {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        let token = try createToken()
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}
