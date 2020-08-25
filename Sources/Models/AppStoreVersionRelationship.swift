//
//  AppStoreVersionRelationship.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Morten Bjerg Gregersen on 24/08/2020.
//

import Foundation

public enum AppStoreVersionRelationship: Codable {
    case app(App)
//    case ageRatingDeclaration(AgeRatingDeclaration)
//    case appStoreReviewDetail(AppStoreReviewDetail)
//    case appStoreVersionLocalizations(AppStoreVersionLocalizations)
//    case appStoreVersionPhasedRelease(AppStoreVersionPhasedRelease)
//    case appStoreVersionSubmission(AppStoreVersionSubmission)
    case build(Build)
//    case idfaDeclaration(IdfaDeclaration)
//    case routingAppCoverage(RoutingAppCoverage)

    enum TypeKeys: String, CodingKey {
        case type
    }

    enum CodingKeys: String, Decodable, CodingKey {
        case app, ageRatingDeclaration, appStoreReviewDetail, ppStoreVersionLocalizations, appStoreVersionPhasedRelease, appStoreVersionSubmission, build, idfaDeclaration, routingAppCoverage
    }

    public init(from decoder: Decoder) throws {
        let type = try decoder.container(keyedBy: TypeKeys.self).decode(CodingKeys.self, forKey: .type)
        switch type {
        case .app:
            self = try .app(App(from: decoder))
        case .build:
            self = try .build(Build(from: decoder))
        default:
            fatalError()
        }
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .app(let value):
            try value.encode(to: encoder)
        case .build(let value):
            try value.encode(to: encoder)
        }
    }
}
