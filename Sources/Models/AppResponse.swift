//
//  AppResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a single resource.
public struct AppResponse: Decodable {

    /// (Required) The resource data.
    public let data: App

    /// The requested relationship data.￼
    /// Possible types: BetaGroup, PrereleaseVersion, BetaAppLocalization, Build, BetaLicenseAgreement, BetaAppReviewDetail
    public let include: [AppResponse.Included]?

    /// (Required) Navigational links that include the self-link.
    public let links: DocumentLinks
    
    public enum Included: Decodable {
        case betaGroup(BetaGroup)
        case prereleaseVersion(PrereleaseVersion)
        case betaAppLocalization(BetaAppLocalization)
        case build(Build)
        case betaLicenseAgreement(BetaLicenseAgreement)
        case betaAppReviewDetail(BetaAppReviewDetail)
        
        public init(from decoder: Decoder) throws {
            if let wrapped = try? BetaGroup(from: decoder) {
                self = .betaGroup(wrapped)
                return
            }
            if let wrapped = try? PrereleaseVersion(from: decoder) {
                self = .prereleaseVersion(wrapped)
                return
            }
            if let wrapped = try? BetaAppLocalization(from: decoder) {
                self = .betaAppLocalization(wrapped)
                return
            }
            if let wrapped = try? Build(from: decoder) {
                self = .build(wrapped)
                return
            }
            if let wrapped = try? BetaLicenseAgreement(from: decoder) {
                self = .betaLicenseAgreement(wrapped)
                return
            }
            if let wrapped = try? BetaAppReviewDetail(from: decoder) {
                self = .betaAppReviewDetail(wrapped)
                return
            }
            
            throw DecodingError.typeMismatch(
                Included.self,
                DecodingError.Context(codingPath: [], debugDescription: "Not convertable to \(Included.self)")
            )
        }
    }
}
