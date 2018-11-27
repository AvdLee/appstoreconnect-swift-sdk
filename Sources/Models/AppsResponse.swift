//
//  AppsResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation

/// A response containing a list of resources.
public struct AppsResponse: Codable {

    /// (Required) The resource data.
    public let data: [App]

    /// The requested relationship data.￼
    ///  Possible types: BetaGroup, PrereleaseVersion, BetaAppLocalization, Build, BetaLicenseAgreement, BetaAppReviewDetail
    public let included: [AppRelationship]?

    /// (Required) Navigational links that include the self-link.
    public let links: PagedDocumentLinks

    /// Paging information.
    public let meta: PagingInformation?
}
