//
//  DevicesResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/24/19.
//

import Foundation

/// A response containing a list of resources.
public struct DevicesResponse: Codable {

    /// The paging information details.
    public let data: [Device]

    /// Navigational links that include the self-link.
    public let links: PagedDocumentLinks

    /// Paging information.
    public let meta: PagingInformation?
}
