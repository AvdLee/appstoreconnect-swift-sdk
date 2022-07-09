//
//  JWTAuthenticator.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Antoine van der Lee on 08/11/2018.
//

import Foundation
import Get

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

extension JWTRequestsAuthenticator: APIClientDelegate {
    func client(_ client: APIClient, willSendRequest request: inout URLRequest) async throws {
        let token = try createToken()
        request.allHTTPHeaderFields = ["Authorization": "Bearer \(token)"]
    }

    func client(_ client: APIClient, didReceiveInvalidResponse response: HTTPURLResponse, data: Data) -> Error {

        APIProvider.Error.requestFailure(response.statusCode, data, response.url)
    }
}
