//
//  JWTDecoder.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Antoine van der Lee on 08/11/2018.
//

import Foundation

internal extension JWT.Token {
    var isExpired: Bool {
        do {
            let decodedBearer = try JWTDecoder.decode(self)
            return decodedBearer.expiryDate.compare(Date()) != ComparisonResult.orderedDescending
        } catch {
            return true
        }
    }
}

/// A decoded `JWT` including the expiry date.
private struct DecodedJWT {
    let expiryDate: Date
}

/// A decoder for JSON Web Tokens which is able to extract the expiry date.
private enum JWTDecoder {

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
                return NSLocalizedString("Malformed jwt, failed to parse JSON value from base64Url \(value)", comment: "Invalid JSON value inside base64Url")
            case .invalidPartCount(let jwt, let parts):
                return NSLocalizedString("Malformed jwt \(jwt) has \(parts) parts when it should have 3 parts", comment: "Invalid amount of jwt parts")
            case .invalidBase64Url(let value):
                return NSLocalizedString("Malformed jwt, failed to decode base64Url value \(value)", comment: "Invalid JWT base64Url value")
            }
        }
    }

    /// Decodes the given bearer and returns a decoded bearer token.
    ///
    /// - Parameter token: The JSON Web Token to decode.
    /// - Returns: The `DecodedJWT` containing information about the token.
    /// - Throws: An error if decoding failed or if the `JWT` input is invalid.
    static func decode(_ token: JWT.Token) throws -> DecodedJWT {
        let parts = token.components(separatedBy: ".")
        guard parts.count == 3 else {
            throw DecodeError.invalidPartCount(token, parts.count)
        }
        let tokenBody = try decodeJWTPart(parts[1])

        guard let expiryTimestamp = tokenBody["exp"] as? Double else {
            throw DecodeError.invalidJSON(parts[1])
        }

        let expiryDate = Date(timeIntervalSince1970: expiryTimestamp)
        return DecodedJWT(expiryDate: expiryDate)
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
