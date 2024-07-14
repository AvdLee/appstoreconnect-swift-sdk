//
//  JWTAuthenticator.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Antoine van der Lee on 08/11/2018.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// An Authenticator for URL Requests which makes use of the RequestAdapter from Alamofire.
final class JWTRequestsAuthenticator {

    private let dispatchQueue = DispatchQueue(label: "JWTRequestsAuthenticator")
    private var cachedToken: JWT.Token?
    private let apiConfiguration: APIConfiguration

    /// The JWT Creator to use for creating the JWT token. Can be overriden for test use cases.
    var jwtCreator: JWTCreatable

    init(apiConfiguration: APIConfiguration) {
        self.apiConfiguration = apiConfiguration
        self.jwtCreator = JWT(keyIdentifier: apiConfiguration.privateKeyID, issuerIdentifier: apiConfiguration.issuerID, expireDuration: apiConfiguration.expirationDuration)
    }

    /// Generates a new JWT Token, but only if the in memory cached one is not expired.
    private func createToken() throws -> JWT.Token {
        return try dispatchQueue.sync {
            if let cachedToken = cachedToken, !cachedToken.isExpired {
                return cachedToken
            }

            let token = try jwtCreator.signedToken(using: apiConfiguration.privateKey)
            cachedToken = token
            return token
        }
    }

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        let token = try createToken()
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}
