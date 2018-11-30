//
//  BetaAppReviewSubmissionsResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a list of resources.
public struct BetaAppReviewSubmissionsResponse: Codable {

    /// The resource data.
    public let data: [BetaAppReviewSubmission]

    /// The requested relationship data.
    public let include: [Build]?

    /// Navigational links that include the self-link.
    public let links: PagedDocumentLinks

    /// Paging information.
    public let meta: PagingInformation?
}
