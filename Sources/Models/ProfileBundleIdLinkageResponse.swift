//
//  ProfileBundleIdLinkageResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/25/19.
//

import Foundation

/// A response containing a list of related resource IDs.
public struct ProfileBundleIdLinkageResponse: Codable {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: bundleIds
        public private(set) var type: String = "bundleIds"
    }

    /// The object types and IDs of the related resources.
    public let data: [ProfileBundleIdLinkageResponse.Data]

    /// Navigational links including the self-link and links to the related data.
    public let links: DocumentLinks
}
