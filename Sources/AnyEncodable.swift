//
//  AnyEncodable.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Rui Costa on 14/03/2020.
//

import Foundation

public struct AnyEncodable: Encodable {
    let base: Encodable
    
    public func encode(to encoder: Encoder) throws {
        try base.encode(to: encoder)
    }
}

extension Encodable {
    var erased: AnyEncodable {
        return AnyEncodable(base: self)
    }
}
