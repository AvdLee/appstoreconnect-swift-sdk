//
//  UserInvitationResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a single resource.
public struct UserInvitationResponse: Codable {

    /// (Required) The resource data.
    public let data: UserInvitation

    /// The requested relationship data.
    public let include: [App]?

    /// (Required) Navigational links that include the self-link.
    public let links: DocumentLinks
}
