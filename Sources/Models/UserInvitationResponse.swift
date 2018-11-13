//
//  UserInvitationResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a single resource.
struct UserInvitationResponse: Decodable {

    /// (Required) The resource data.
    let data: UserInvitation

    /// The requested relationship data.
    let include: [App]?

    /// (Required) Navigational links that include the self-link.
    let links: DocumentLinks
}
