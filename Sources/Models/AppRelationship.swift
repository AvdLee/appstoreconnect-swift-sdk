//
//  AppRelationships.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 17/11/2018.
//

import Foundation

public enum AppRelationship: Codable {
    case betaGroup(BetaGroup)
    case prereleaseVersion(PrereleaseVersion)
    case betaAppLocalization(BetaAppLocalization)
    case build(Build)
    case betaLicenseAgreement(BetaLicenseAgreement)
    case betaAppReviewDetail(BetaAppReviewDetail)
    
    enum CodingKeys: String, Decodable, CodingKey {
        case type
        case betaGroups, preReleaseVersions, betaAppLocalizations, builds, betaLicenseAgreements, betaAppReviewDetails
    }

    public init(from decoder: Decoder) throws {
        switch try decoder.container(keyedBy: CodingKeys.self).decode(CodingKeys.self, forKey: .type) {
        case .betaGroups:
            self = try .betaGroup(BetaGroup(from: decoder))
        case .preReleaseVersions:
            self = try .prereleaseVersion(PrereleaseVersion(from: decoder))
        case .betaAppLocalizations:
            self = try .betaAppLocalization(BetaAppLocalization(from: decoder))
        case .builds:
            self = try .build(Build(from: decoder))
        case .betaLicenseAgreements:
            self = try .betaLicenseAgreement(BetaLicenseAgreement(from: decoder))
        case .betaAppReviewDetails:
            self = try .betaAppReviewDetail(BetaAppReviewDetail(from: decoder))
        default:
            throw DecodingError.typeMismatch(
                AppRelationship.self,
                DecodingError.Context(codingPath: [], debugDescription: "Not convertable to \(AppRelationship.self)")
            )
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .betaGroup(let value):
            try value.encode(to: encoder)
        case .prereleaseVersion(let value):
            try value.encode(to: encoder)
        case .betaAppLocalization(let value):
            try value.encode(to: encoder)
        case .build(let value):
            try value.encode(to: encoder)
        case .betaLicenseAgreement(let value):
            try value.encode(to: encoder)
        case .betaAppReviewDetail(let value):
            try value.encode(to: encoder)
        }
    }
}
