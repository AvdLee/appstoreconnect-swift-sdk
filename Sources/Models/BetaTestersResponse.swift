//
//  BetaTestersResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a list of resources.
public struct BetaTestersResponse: Codable {

    /// (Required) The resource data.
    public let data: [BetaTester]

    /// The requested relationship data.￼
    ///  Possible types: App, BetaGroup, Build
    public let include: [BetaTesterRelationship]?

    /// (Required) Navigational links that include the self-link.
    public let links: PagedDocumentLinks

    /// Paging information.
    public let meta: PagingInformation?
}
