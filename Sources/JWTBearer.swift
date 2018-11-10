//
//  JWTBearer.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Antoine van der Lee on 08/11/2018.
//

import Foundation

typealias Bearer = String

internal extension Bearer {
    var isExpired: Bool {
        do {
            let decodedBearer = try BearerDecoder.decode(self)
            return decodedBearer.expiryDate.compare(Date()) != ComparisonResult.orderedDescending
        } catch {
            return true
        }
    }
}

/// A decoded `Bearer` including the expiry date.
private struct DecodedBearer {
    let expiryDate: Date
}

/// A decoder for JWT bearers which is able to extract the expiry date.
private struct BearerDecoder {

    public enum DecodeError: LocalizedError {
        /// When either the header or body parts cannot be base64 decoded
        case invalidBase64Url(String)

        /// When either the header or body decoded values is not a valid JSON object
        case invalidJSON(String)

        /// When the token doesnt have the required amount of parts (header, body and signature)
        case invalidPartCount(String, Int)

        public var localizedDescription: String {
            switch self {
            case .invalidJSON(let value):
                return NSLocalizedString("Malformed jwt token, failed to parse JSON value from base64Url \(value)", comment: "Invalid JSON value inside base64Url")
            case .invalidPartCount(let jwt, let parts):
                return NSLocalizedString("Malformed jwt token \(jwt) has \(parts) parts when it should have 3 parts", comment: "Invalid amount of jwt parts")
            case .invalidBase64Url(let value):
                return NSLocalizedString("Malformed jwt token, failed to decode base64Url value \(value)", comment: "Invalid JWT token base64Url value")
            }
        }
    }

    /// Decodes the given bearer and returns a decoded bearer token.
    ///
    /// - Parameter bearer: The `Bearer` to decode.
    /// - Returns: The `DecodedBearer` containing information about the bearer.
    /// - Throws: An error if decoding failed or if the `Bearer` input is invalid.
    static func decode(_ bearer: Bearer) throws -> DecodedBearer {
        let parts = bearer.components(separatedBy: ".")
        guard parts.count == 3 else {
            throw DecodeError.invalidPartCount(bearer, parts.count)
        }
        let bearerBody = try decodeJWTPart(parts[1])

        guard let expiryTimestamp = bearerBody["exp"] as? Double else {
            throw DecodeError.invalidJSON(parts[1])
        }

        let expiryDate = Date(timeIntervalSince1970: expiryTimestamp)
        return DecodedBearer(expiryDate: expiryDate)
    }

    /// Base64 URL decode the given string into `Data` which is in this case encoded JSON data.
    private static func base64UrlDecode(_ value: String) -> Data? {
        var base64 = value
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
        let requiredLength = 4 * ceil(length / 4.0)
        let paddingLength = requiredLength - length
        if paddingLength > 0 {
            let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
            base64 += padding
        }
        return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }

    /// Decodes the given JSON Web Token part into a JSON dictionary.
    ///
    /// - Parameter value: The JSON Web Token part to decode.
    /// - Returns: A JSON Dictionary containing values from the JSON Web Token.
    /// - Throws: An error if decoding failed.
    private static func decodeJWTPart(_ value: String) throws -> [String: Any] {
        guard let bodyData = base64UrlDecode(value) else {
            throw DecodeError.invalidBase64Url(value)
        }

        guard let json = try? JSONSerialization.jsonObject(with: bodyData, options: []), let payload = json as? [String: Any] else {
            throw DecodeError.invalidJSON(value)
        }

        return payload
    }
}
