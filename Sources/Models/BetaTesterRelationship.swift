//
//  BetaTesterRelationship.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 17/11/2018.
//

import Foundation

public enum BetaTesterRelationship: Codable {
    case app(App)
    case betaGroup(BetaGroup)
    case build(Build)
    
    enum CodingKeys: String, Decodable, CodingKey {
        case type
        case apps, betaGroups, builds
    }
    
    public init(from decoder: Decoder) throws {
        switch try decoder.container(keyedBy: CodingKeys.self).decode(CodingKeys.self, forKey: .type) {
        case .apps:
            self = try .app(App(from: decoder))
        case .betaGroups:
            self = try .betaGroup(BetaGroup(from: decoder))
        case .builds:
            self = try .build(Build(from: decoder))
        default:
            throw DecodingError.typeMismatch(
                BetaTesterRelationship.self,
                DecodingError.Context(codingPath: [], debugDescription: "Not convertable to \(BetaTesterRelationship.self)")
            )
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .app(let value):
            try value.encode(to: encoder)
        case .betaGroup(let value):
            try value.encode(to: encoder)
        case .build(let value):
            try value.encode(to: encoder)
        }
    }
}
