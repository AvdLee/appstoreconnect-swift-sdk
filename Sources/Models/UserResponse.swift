//
//  UserResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a single resource.
public struct UserResponse: Codable {

    /// The resource data.
    public let data: User

    /// The requested relationship data.
    public let include: [App]?

    /// Navigational links that include the self-link.
    public let links: DocumentLinks
}
