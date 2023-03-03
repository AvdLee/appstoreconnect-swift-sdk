//
//  JWT.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Antoine van der Lee on 08/11/2018.
//

import Foundation
import Crypto

/// The JWT Header contains information specific to the App Store Connect API Keys, such as algorithm and keys.
private struct Header: Codable {

    enum CodingKeys: String, CodingKey {
        case algorithm = "alg"
        case keyIdentifier = "kid"
        case tokenType = "typ"
    }

    /// All JWTs for App Store Connect API must be signed with ES256 encryption
    let algorithm: String = "ES256"

    /// Your private key ID from App Store Connect (Ex: 2X9R4HXF34)
    let keyIdentifier: String

    /// The required type for signing requests to the App Store Connect API
    let tokenType: String = "JWT"
}

/// The JWT Payload contains information specific to the App Store Connect APIs, such as issuer ID and expiration time.
private struct Payload: Codable {

    enum CodingKeys: String, CodingKey {
        case issuerIdentifier = "iss"
        case expirationTime = "exp"
        case audience = "aud"
    }

    /// Your issuer identifier from the API Keys page in App Store Connect (Ex: 57246542-96fe-1a63-e053-0824d011072a)
    let issuerIdentifier: String

    /// The token's expiration time, in Unix epoch time; tokens that expire more than 20 minutes in the future are not valid (Ex: 1528408800)
    let expirationTime: TimeInterval

    /// The required audience which is set to the App Store Connect version.
    let audience: String = "appstoreconnect-v1"
}

protocol JWTCreatable {
    func signedToken(using privateKey: JWT.PrivateKey) throws -> JWT.Token
}

struct JWT: Codable, JWTCreatable {

    public enum Error: Swift.Error, LocalizedError {

        case invalidDigest
        case invalidBase64EncodedPrivateKey
        case invalidPrivateKey

        public var localizedDescription: String {
            switch self {
            case .invalidDigest:
                return "Failed to generate a digest"
            case .invalidBase64EncodedPrivateKey:
                return "The private key is not encoded in Base64 format"
            case .invalidPrivateKey:
                return "The private key is not valid"
            }
        }
    }

    typealias Token = String
    typealias PrivateKey = P256.Signing.PrivateKey

    typealias DateProvider = () -> Date
    static let defaultDateProvider: DateProvider = {
        Date()
    }

    /// The JWT Header contains information specific to the App Store Connect API Keys, such as algorithm and keys.
    private let header: Header

    /// Your issuer identifier from the API Keys page in App Store Connect (Ex: 57246542-96fe-1a63-e053-0824d011072a)
    private let issuerIdentifier: String

    /// The token's expiration duration. Tokens that expire more than 20 minutes in the future are not valid, so set it to a max of 20 minutes.
    private let expireDuration: TimeInterval

    /// Creates a new JWT Factory to create signed requests for the App Store Connect API.
    ///
    /// - Parameters:
    ///   - keyIdentifier: Your private key ID from App Store Connect (Ex: 2X9R4HXF34)
    ///   - issuerIdentifier: Your issuer identifier from the API Keys page in App Store Connect (Ex: 57246542-96fe-1a63-e053-0824d011072a)
    ///   - expireDuration: The token's expiration duration. Tokens that expire more than 20 minutes in the future are not valid, so set it to a max of 20 minutes.
    public init(keyIdentifier: String, issuerIdentifier: String, expireDuration: TimeInterval) {
        header = Header(keyIdentifier: keyIdentifier)
        self.issuerIdentifier = issuerIdentifier
        self.expireDuration = expireDuration
    }

    /// Combine the header and the payload as a digest for signing.
    private func digest(dateProvider: DateProvider) throws -> String {
        let payload = Payload(issuerIdentifier: issuerIdentifier, expirationTime: dateProvider().addingTimeInterval(expireDuration).timeIntervalSince1970)
        let headerString = try JSONEncoder().encode(header.self).base64URLEncoded()
        let payloadString = try JSONEncoder().encode(payload.self).base64URLEncoded()
        return "\(headerString).\(payloadString)"
    }

    /// Creates a signed JWT Token which can be used as a Bearer Authentication header value for signing App Store Connect API Requests.
    ///
    /// - Parameter privateKey: The .p8 private key to use for signing. You can get this value from the downloaded .p8 file.
    /// - Returns: A signed JWT.Token value which can be used as a value for the Bearer Authentication header.
    /// - Throws: An error if something went wrong, like a JWT.Error.
    public func signedToken(using privateKey: JWT.PrivateKey) throws -> JWT.Token {
        try signedToken(using: privateKey, dateProvider: Self.defaultDateProvider)
    }

    func signedToken(using privateKey: JWT.PrivateKey, dateProvider: DateProvider) throws -> JWT.Token {
        let rawDigest = try self.digest(dateProvider: dateProvider)
        guard let digest = rawDigest.data(using: .utf8) else {
            throw JWT.Error.invalidDigest
        }
        let signature = try privateKey.signature(for: digest)
        let encoded = signature.rawRepresentation.base64URLEncoded()
        return "\(rawDigest).\(encoded)"
    }
}

internal extension Data {

    /// Encodes the data using base64.
    ///
    /// - Returns: A base64 encoded `String`.
    func base64URLEncoded() -> String {
        return base64EncodedString()
            .replacingOccurrences(of: "=", with: "")
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
    }
}
