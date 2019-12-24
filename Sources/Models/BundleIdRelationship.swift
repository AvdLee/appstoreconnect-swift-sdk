//
//  BundleIdsRelationship.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/22/19.
//

import Foundation

public enum BundleIdRelationship: Codable {
    case profile(Profile)
    case bundleIdCapability(BundleIdCapability)

    enum TypeKeys: String, CodingKey {
        case type
    }
    enum CodingKeys: String, Decodable, CodingKey {
        case profile, bundleIdCapability
    }

    public init(from decoder: Decoder) throws {
        let type = try decoder.container(keyedBy: TypeKeys.self).decode(CodingKeys.self, forKey: .type)
        switch type {
        case .profile:
            self = try .profile(Profile(from: decoder))
        case .bundleIdCapability:
            self = try .bundleIdCapability(BundleIdCapability(from: decoder))
        }
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .profile(let value):
            try value.encode(to: encoder)
        case .bundleIdCapability(let value):
            try value.encode(to: encoder)
        }
    }
}

