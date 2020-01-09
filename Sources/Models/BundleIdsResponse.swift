//
//  BundleIdsResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/22/19.
//

import Foundation

/// A response containing a list of resources.
public struct BundleIdsResponse: Codable {

    /// The resource data.
    public let data: [BundleId]

    /// The requested relationship data.
    public let included: [BundleIdRelationship]?

    /// Navigational links that include the self-link.
    public let links: PagedDocumentLinks

    /// Paging information.
    public let meta: PagingInformation?
}
