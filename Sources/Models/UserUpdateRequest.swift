//
//  UserUpdateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
public struct UserUpdateRequest: Decodable {

    /// (Required) The resource data.
    public let data: UserUpdateRequest.Data
    
    public struct Data: Decodable {
    
        /// The resource's attributes.
        public let attributes: UserUpdateRequest.Data.Attributes?
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// The types and IDs of the related data to update.
        public let relationships: UserUpdateRequest.Data.Relationships?
    
        /// (Required) The resource type.Value: users
        public let type: String
    }
}

/// MARK: UserUpdateRequest.Data
extension UserUpdateRequest.Data {
    /// Attributes that describe a resource.
    public struct Attributes: Decodable {
    
        /// Assigned user roles that determine the user's access to sections of App Store Connect and tasks they can perform.
        public let allAppsVisible: Bool?
    
        /// A Boolean value that indicates the user's specified role allows access to the provisioning functionality on the Apple Developer website.
        public let provisioningAllowed: Bool?
    
        /// Assigned user roles that determine the user's access to sections of App Store Connect and tasks they can perform.
        public let roles: [UserRole]?
    }
    
    public struct Relationships: Decodable {
    
        /// UserUpdateRequest.Data.Relationships.VisibleApps
        public let visibleApps: UserUpdateRequest.Data.Relationships.VisibleApps?
    }
}

/// MARK: UserUpdateRequest.Data.Relationships
extension UserUpdateRequest.Data.Relationships {
    
    public struct VisibleApps: Decodable {
    
        /// [UserUpdateRequest.Data.Relationships.VisibleApps.Data]
        public let data: [UserUpdateRequest.Data.Relationships.VisibleApps.Data]?
    }
}

/// MARK: UserUpdateRequest.Data.Relationships.VisibleApps
extension UserUpdateRequest.Data.Relationships.VisibleApps {
    
    public struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: apps
        public let type: String
    }
}
