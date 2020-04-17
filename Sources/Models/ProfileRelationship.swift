//
//  ProfileRelationship.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Oliver Jones on 17/4/20.
//

import Foundation

import Foundation

public enum ProfileRelationship: Codable {
    case bundleId(BundleId)
    case certificate(Certificate)
    case device(Device)

    enum TypeKeys: String, CodingKey {
        case type
    }
    enum CodingKeys: String, Decodable, CodingKey {
        case bundleIds, certificates, devices
    }

    public init(from decoder: Decoder) throws {
        let type = try decoder.container(keyedBy: TypeKeys.self).decode(CodingKeys.self, forKey: .type)
        switch type {
        case .bundleIds:
            self = try .bundleId(BundleId(from: decoder))
        case .certificates:
            self = try .certificate(Certificate(from: decoder))
        case .devices:
            self = try .device(Device(from: decoder))
        }
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .bundleId(let value):
            try value.encode(to: encoder)
        case .certificate(let value):
            try value.encode(to: encoder)
        case .device(let value):
            try value.encode(to: encoder)
        }
    }
}
