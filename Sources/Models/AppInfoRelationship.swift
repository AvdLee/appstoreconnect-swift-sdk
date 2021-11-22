//
//  AppInfoRelationship.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Morten Bjerg Gregersen on 23/08/2020.
//

import Foundation

public enum AppInfoRelationship: Codable {
    case app(App)
//    case appInfoLocalizations([AppInfoLocalization])
//    case primaryCategory(AppCategory)
//    case primarySubcategoryOne(AppCategory)
//    case primarySubcategoryTwo(AppCategory)
//    case secondaryCategory(AppCategory)
//    case secondarySubcategoryOne(AppCategory)
//    case secondarySubcategoryTwo(AppCategory)

    enum TypeKeys: String, CodingKey {
        case type
    }

    enum CodingKeys: String, Decodable, CodingKey {
        case app
//        case appInfoLocalizations
//        case primaryCategory
//        case primarySubcategoryOne
//        case primarySubcategoryTwo
//        case secondaryCategory
//        case secondarySubcategoryOne
//        case secondarySubcategoryTwo
    }

    public init(from decoder: Decoder) throws {
        let type = try decoder.container(keyedBy: TypeKeys.self).decode(CodingKeys.self, forKey: .type)
        switch type {
        case .app:
            self = try .app(App(from: decoder))
        }
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .app(let value):
            try value.encode(to: encoder)
        }
    }
}
