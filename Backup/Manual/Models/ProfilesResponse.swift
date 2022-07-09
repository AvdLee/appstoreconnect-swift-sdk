//
//  ProfileResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/22/19.
//

import Foundation

/// A response containing a list of resources.
public struct ProfilesResponse: Codable {

    /// The resource data.
    public let data: [Profile]

    /// Navigational links that include the self-link.
    public let links: PagedDocumentLinks

    /// Paging information.
    public let meta: PagingInformation?

    /// The requested relationship data.￼
    ///  Possible types: BundleId, Device, Certificate
    public let included: [ProfileRelationship]?
}
