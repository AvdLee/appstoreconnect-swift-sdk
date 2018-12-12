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
    
    enum TypeKeys: String, CodingKey {
        case type
    }
    enum CodingKeys: String, Decodable, CodingKey {
        case apps, betaGroups, builds
    }
    
    public init(from decoder: Decoder) throws {
        switch try decoder.container(keyedBy: TypeKeys.self).decode(CodingKeys.self, forKey: .type) {
        case .apps:
            self = try .app(App(from: decoder))
        case .betaGroups:
            self = try .betaGroup(BetaGroup(from: decoder))
        case .builds:
            self = try .build(Build(from: decoder))
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
