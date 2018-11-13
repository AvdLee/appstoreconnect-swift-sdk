//
//  ECKeyData.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Antoine van der Lee on 08/11/2018.
//

import Foundation

public typealias ECKeyData = Data

extension ECKeyData {
    public func toPrivateKey() throws -> ECPrivateKey {
        var error: Unmanaged<CFError>?

        guard let privateKey =
            SecKeyCreateWithData(self as CFData,
                                 [kSecAttrKeyType: kSecAttrKeyTypeECSECPrimeRandom,
                                  kSecAttrKeyClass: kSecAttrKeyClassPrivate,
                                  kSecAttrKeySizeInBits: 256] as CFDictionary,
                                 &error) else {
                                    throw JWT.Error.privateKeyConversionFailed
        }
        return privateKey
    }

    public func toPublicKey() throws -> ECPrivateKey {
        var error: Unmanaged<CFError>?

        guard let publicKey =
            SecKeyCreateWithData(self as CFData,
                                 [kSecAttrKeyType: kSecAttrKeyTypeECSECPrimeRandom,
                                  kSecAttrKeyClass: kSecAttrKeyClassPublic,
                                  kSecAttrKeySizeInBits: 256] as CFDictionary,
                                 &error) else {
                                    throw JWT.Error.privateKeyConversionFailed
        }
        return publicKey
    }
}
