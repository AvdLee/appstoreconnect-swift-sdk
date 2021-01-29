//
//  AppStoreVersionLocalizationResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Kirill Budevich on 1/27/21.
//

import Foundation

public struct AppStoreVersionLocalizationResponse: Codable {
    /// The resource data.
    public let data: AppStoreVersionLocalization

    /// The requested relationship data.￼
    ///  Possible types: AgeRatingDeclaration, AppStoreVersionLocalization, Build, AppStoreVersionPhasedRelease, RoutingAppCoverage, AppStoreReviewDetail, AppStoreVersionSubmission, IdfaDeclaration
    public let included: [AppStoreVersionRelationship]?

    /// Navigational links that include the self-link.
    public let links: PagedDocumentLinks
}
