//
//  PreReleaseVersionsResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a list of resources.
public struct PreReleaseVersionsResponse: Codable {

    /// (Required) The resource data.
    public let data: [PrereleaseVersion]

    /// The requested relationship data.￼
    ///  Possible types: Build, App
    public let include: [PreReleaseVersionRelationship]?

    /// (Required) Navigational links that include the self-link.
    public let links: PagedDocumentLinks

    /// Paging information.
    public let meta: PagingInformation?
}
