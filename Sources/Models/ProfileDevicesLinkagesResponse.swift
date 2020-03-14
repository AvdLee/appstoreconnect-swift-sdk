//
//  ProfileDevicesLinkagesResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/26/19.
//

import Foundation

/// A response containing a list of related resource IDs.
public struct ProfileDevicesLinkagesResponse: Codable {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: devices
        public let type: String = "devices"
    }

    /// The object types and IDs of the related resources.
    public let data: [ProfileDevicesLinkagesResponse.Data]

    /// Navigational links including the self-link and links to the related data.
    public let links: DocumentLinks

    /// Paging information.
    public let meta: PagingInformation?
}
