//
//  UserInvitationVisibleAppsLinkagesResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation

/// A response containing a list of related resource IDs.
public struct UserInvitationVisibleAppsLinkagesResponse: Codable {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: apps
        public private(set) var type: String = "apps"
    }

    /// The object types and IDs of the related resources.
    public let data: [UserInvitationVisibleAppsLinkagesResponse.Data]

    /// Navigational links including the self-link and links to the related data.
    public let links: PagedDocumentLinks

    /// Paging information.
    public let meta: PagingInformation?
}
