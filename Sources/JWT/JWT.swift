//
//  JWT.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Antoine van der Lee on 08/11/2018.
//

import Foundation

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
    func signedToken(using privateKey: JWT.P8PrivateKey) throws -> JWT.Token
}

struct JWT: Codable, JWTCreatable {

    public enum Error: Swift.Error, LocalizedError {

        /// In case the provided .p8 private key is of an invalid format.
        case invalidP8PrivateKey

        /// In case the private key could not be converted using the EC Algoritm
        case privateKeyConversionFailed

        /// In case the ES256 signing failed with the given digest containing the header and payload.
        case ES256SigningFailed

        /// In case the ASN1 could not be generated.
        case invalidASN1

        public var localizedDescription: String {
            switch self {
            case .invalidP8PrivateKey:
                return "The provided .p8 private key is of an invalid format"
            case .privateKeyConversionFailed:
                return "Something went wrong with converting the private key"
            case .ES256SigningFailed:
                return "Signing the digest containing the header and payload failed using the ES256 algorithm"
            case .invalidASN1:
                return "Failed to generate the ASN1 value out of the private key"
            }
        }
    }

    typealias Token = String
    typealias P8PrivateKey = String

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
    public func signedToken(using privateKey: P8PrivateKey) throws -> JWT.Token {
        try signedToken(using: privateKey, dateProvider: Self.defaultDateProvider)
    }

    func signedToken(using privateKey: P8PrivateKey, dateProvider: DateProvider) throws -> JWT.Token {
        let digest = try self.digest(dateProvider: dateProvider)

        let signature = try privateKey.toASN1()
            .toECKeyData()
            .toPrivateKey()
            .es256Sign(digest: digest)

        return "\(digest).\(signature)"
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

internal extension String {
    func base64URLDecoded() -> String {
        var base64 = replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        if base64.count % 4 != 0 {
            base64.append(String(repeating: "=", count: 4 - base64.count % 4))
        }
        return base64
    }
}

private extension JWT.P8PrivateKey {

    /// Converts the PEM formatted .p8 private key to a DER-encoded ASN.1 data object.
    func toASN1() throws -> ASN1 {
        guard let asn1 = Data(base64Encoded: self) else {
            throw JWT.Error.invalidP8PrivateKey
        }
        return asn1
    }
}
