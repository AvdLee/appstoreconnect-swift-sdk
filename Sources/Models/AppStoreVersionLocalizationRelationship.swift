//
//  AppStoreVersionLocalizationRelationship.swift
//
//  Created by Kirill Budevich on 1/27/21.
//

import Foundation

public enum AppStoreVersionLocalizationRelationship: Codable {
    case appStoreVersion(AppStoreVersion)

    enum TypeKeys: String, CodingKey {
        case type
    }
    enum CodingKeys: String, Decodable, CodingKey {
        case appStoreVersion
    }

    public init(from decoder: Decoder) throws {
        switch try decoder.container(keyedBy: TypeKeys.self).decode(CodingKeys.self, forKey: .type) {
        case .appStoreVersion:
            self = try .appStoreVersion(AppStoreVersion(from: decoder))
        }
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .appStoreVersion(let value):
            try value.encode(to: encoder)
        }
    }
}
