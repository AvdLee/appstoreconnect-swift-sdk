//
//  ECPrivateKey.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Antoine van der Lee on 08/11/2018.
//

import Foundation
import Crypto

public typealias ECPrivateKey = P256.Signing.PrivateKey

extension ECPrivateKey {
    public func es256Sign(digest: String) throws -> String {
        guard let message = digest.data(using: .utf8) else {
            throw JWT.Error.ES256SigningFailed
        }

        let digestData = SHA256.hash(data: message)
        let signature = try P256.Signing.PrivateKey.signature(self)(for: digestData)

        return signature.rawRepresentation.base64URLEncoded()
    }
}
