//
//  AppStoreVersionLocalizationRelationship.swift
//
//  Created by Kirill Budevich on 1/27/21.
//

import Foundation

public enum AppStoreVersionLocalizationRelationship: Codable {
//    case appScreenshotSet(AppScreenshotSet)
//    case appPreviewSet(AppPreviewSet)

    enum TypeKeys: String, CodingKey {
        case type
    }

    enum CodingKeys: String, Decodable, CodingKey {
        case appScreenshotSet, appPreviewSet
    }

    public init(from decoder: Decoder) throws {
        let type = try decoder.container(keyedBy: TypeKeys.self).decode(CodingKeys.self, forKey: .type)
        switch type {
        default:
            fatalError()
        }
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        default: break
        }
    }
}
