//
//  PreReleaseVersionRelationship.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 17/11/2018.
//

import Foundation

public enum PreReleaseVersionRelationship: Codable {
    case build(Build)
    case app(App)
    
    enum CodingKeys: String, Decodable, CodingKey {
        case type
        case builds, apps
    }
    
    public init(from decoder: Decoder) throws {
        switch try decoder.container(keyedBy: CodingKeys.self).decode(CodingKeys.self, forKey: .type) {
        case .builds:
            self = try .build(Build(from: decoder))
        case .apps:
            self = try .app(App(from: decoder))
        default:
            throw DecodingError.typeMismatch(
                PreReleaseVersionRelationship.self,
                DecodingError.Context(codingPath: [], debugDescription: "Not convertable to \(PreReleaseVersionRelationship.self)")
            )
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .build(let value):
            try value.encode(to: encoder)
        case .app(let value):
            try value.encode(to: encoder)
        }
    }
}
