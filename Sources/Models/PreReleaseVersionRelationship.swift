//
//  PreReleaseVersionRelationship.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 17/11/2018.
//

import Foundation

public enum PreReleaseVersionRelationship: Decodable {
    case build(Build)
    case app(App)
    
    public init(from decoder: Decoder) throws {
        enum CodingKeys: String, Decodable, CodingKey {
            case type
            case builds, apps
        }
        
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
}
