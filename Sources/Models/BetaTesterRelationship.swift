//
//  BetaTesterRelationship.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 17/11/2018.
//

import Foundation

public enum BetaTesterRelationship: Decodable {
    case app(App)
    case betaGroup(BetaGroup)
    case build(Build)
    
    public init(from decoder: Decoder) throws {
        enum CodingKeys: String, Decodable, CodingKey {
            case type
            case apps, betaGroups, builds
        }
        
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
}
