//
//  BundleIdResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Rui Costa on 07/12/2019.
//

import Foundation

/// A response containing a single resource.
public struct BundleIdResponse: Decodable {

    /// The resource data.
    public let data: BundleId

    /// Navigational links including the self-link and links to the related data.
    public let links: DocumentLinks

    /// The requested relationship data.￼
    ///  Possible types: Profile, BundleIdCapability
    public let included: [BundleIdRelationship]?
}
