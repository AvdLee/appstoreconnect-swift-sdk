//
//  AppStoreVersionResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Morten Bjerg Gregersen on 24/08/2020.
//

import Foundation

public struct AppStoreVersionResponse: Codable {
    /// The resource data.
    public let data: AppStoreVersion

    /// The requested relationship data.￼
    ///  Possible types: AgeRatingDeclaration, AppStoreVersionLocalization, Build, AppStoreVersionPhasedRelease, RoutingAppCoverage, AppStoreReviewDetail, AppStoreVersionSubmission, IdfaDeclaration
    public let included: [AppStoreVersionRelationship]?

    /// Navigational links that include the self-link.
    public let links: PagedDocumentLinks
}
