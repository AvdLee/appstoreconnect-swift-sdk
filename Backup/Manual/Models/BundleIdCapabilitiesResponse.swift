//
//  BundleIdCapabilitiesResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/23/19.
//

import Foundation

/// A response containing a list of related resource IDs.
public struct BundleIdCapabilitiesResponse: Codable {

    /// The object types and IDs of the related resources.
    public let data: [BundleIdCapability]

    /// Navigational links including the self-link and links to the related data.
    public let links: DocumentLinks

    /// Paging information.
    public let meta: PagingInformation?
}
