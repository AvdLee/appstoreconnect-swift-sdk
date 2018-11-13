//
//  UserUpdateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
struct UserUpdateRequest: Decodable {

    /// (Required) The resource data.
    let data: UserUpdateRequest.Data
    
    struct Data: Decodable {
    
        /// The resource's attributes.
        let attributes: UserUpdateRequest.Data.Attributes?
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// The types and IDs of the related data to update.
        let relationships: UserUpdateRequest.Data.Relationships?
    
        /// (Required) The resource type.Value: users
        let type: String
    }
}

/// MARK: UserUpdateRequest.Data
extension UserUpdateRequest.Data {
    /// Attributes that describe a resource.
    struct Attributes: Decodable {
    
        /// Assigned user roles that determine the user's access to sections of App Store Connect and tasks they can perform.
        let allAppsVisible: Bool?
    
        /// A Boolean value that indicates the user's specified role allows access to the provisioning functionality on the Apple Developer website.
        let provisioningAllowed: Bool?
    
        /// Assigned user roles that determine the user's access to sections of App Store Connect and tasks they can perform.
        let roles: [UserRole]?
    }
    
    struct Relationships: Decodable {
    
        /// UserUpdateRequest.Data.Relationships.VisibleApps
        let visibleApps: UserUpdateRequest.Data.Relationships.VisibleApps?
    }
}

/// MARK: UserUpdateRequest.Data.Relationships
extension UserUpdateRequest.Data.Relationships {
    
    struct VisibleApps: Decodable {
    
        /// [UserUpdateRequest.Data.Relationships.VisibleApps.Data]
        let data: [UserUpdateRequest.Data.Relationships.VisibleApps.Data]?
    }
}

/// MARK: UserUpdateRequest.Data.Relationships.VisibleApps
extension UserUpdateRequest.Data.Relationships.VisibleApps {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: apps
        let type: String
    }
}
