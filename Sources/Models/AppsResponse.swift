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
            enum TypeCodingKeys: String, CodingKey { case type }
            
            let type = try decoder.container(keyedBy: TypeCodingKeys.self).decode(String.self, forKey: .type)
            switch type {
            case "betaGroups":
                self = try .betaGroup(BetaGroup(from: decoder))
            case "preReleaseVersions":
                self = try .prereleaseVersion(PrereleaseVersion(from: decoder))
            case "betaAppLocalizations":
                self = try .betaAppLocalization(BetaAppLocalization(from: decoder))
            case "builds":
                self = try .build(Build(from: decoder))
            case "betaLicenseAgreements":
                self = try .betaLicenseAgreement(BetaLicenseAgreement(from: decoder))
            case "betaAppReviewDetails":
                self = try .betaAppReviewDetail(BetaAppReviewDetail(from: decoder))
            default:
                print("\(type)")
                throw DecodingError.typeMismatch(
                    Included.self,
                    DecodingError.Context(codingPath: [], debugDescription: "Not convertable to \(Included.self)")
                )
            }
        }
    }
}
