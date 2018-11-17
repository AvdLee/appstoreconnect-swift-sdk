//
//  AppsResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a list of resources.
public struct AppsResponse: Decodable {

    /// (Required) The resource data.
    public let data: [App]

    /// The requested relationship data.￼
    ///  Possible types: BetaGroup, PrereleaseVersion, BetaAppLocalization, Build, BetaLicenseAgreement, BetaAppReviewDetail
    public let include: [AppsResponse.Included]?

    /// (Required) Navigational links that include the self-link.
    public let links: PagedDocumentLinks

    /// Paging information.
    public let meta: PagingInformation?
    
    public enum Included: Decodable {
        case betaGroup(BetaGroup)
        case prereleaseVersion(PrereleaseVersion)
        case betaAppLocalization(BetaAppLocalization)
        case build(Build)
        case betaLicenseAgreement(BetaLicenseAgreement)
        case betaAppReviewDetail(BetaAppReviewDetail)
        
        public init(from decoder: Decoder) throws {
            enum CodingKeys: String, Decodable, CodingKey {
                case type
                case betaGroups, prereleaseVersions, betaAppLocalizations, builds, betaLicenseAgreements, betaAppReviewDetails
            }
            
            switch try decoder.container(keyedBy: CodingKeys.self).decode(CodingKeys.self, forKey: .type) {
            case .betaGroups:
                self = try .betaGroup(BetaGroup(from: decoder))
            case .prereleaseVersions:
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
                    Included.self,
                    DecodingError.Context(codingPath: [], debugDescription: "Not convertable to \(Included.self)")
                )
            }
        }
    }
}

extension AppsResponse.Included {
    
    public var betaGroup: BetaGroup? {
        switch self {
        case .betaGroup(let value):
            return value
        default:
            return nil
        }
    }
    
    public var prereleaseVersion: PrereleaseVersion? {
        switch self {
        case .prereleaseVersion(let value):
            return value
        default:
            return nil
        }
    }
    
    public var betaAppLocalization: BetaAppLocalization? {
        switch self {
        case .betaAppLocalization(let value):
            return value
        default:
            return nil
        }
    }
    
    public var build: Build? {
        switch self {
        case .build(let value):
            return value
        default:
            return nil
        }
    }
    
    public var betaLicenseAgreement: BetaLicenseAgreement? {
        switch self {
        case .betaLicenseAgreement(let value):
            return value
        default:
            return nil
        }
    }
    
    public var betaAppReviewDetail: BetaAppReviewDetail? {
        switch self {
        case .betaAppReviewDetail(let value):
            return value
        default:
            return nil
        }
    }
}
