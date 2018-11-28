//
//  UserUpdateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
public struct UserUpdateRequest: Codable {

    /// - Parameters:
    ///   - id: The opaque resource ID that uniquely identifies the resource.
    ///   - allAppsVisible: Assigned user roles that determine the user's access to sections of App Store Connect and tasks they can perform.
    ///   - provisioningAllowed: A Boolean value that indicates the user's specified role allows access to the provisioning functionality on the Apple Developer website.
    ///   - roles: Assigned user roles that determine the user's access to sections of App Store Connect and tasks they can perform.
    ///   - appsVisibleIds: Array of opaque resource ID that uniquely identifies the resources.
    public init(id: String,
                allAppsVisible: Bool? = nil,
                provisioningAllowed: Bool? = nil,
                roles: [UserRole]? = nil,
                appsVisibleIds: [String]? = nil) {
        data = .init(
            attributes: .init(
                allAppsVisible: allAppsVisible,
                provisioningAllowed: provisioningAllowed,
                roles: roles),
            id: id,
            relationships: .init(
                visibleApps: .init(data: appsVisibleIds?.map({ Data.Relationships.VisibleApps.Data(id: $0) }))))
    }
    
    /// (Required) The resource data.
    public let data: UserUpdateRequest.Data
    
    public struct Data: Codable {
    
        /// The resource's attributes.
        public let attributes: UserUpdateRequest.Data.Attributes?
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// The types and IDs of the related data to update.
        public let relationships: UserUpdateRequest.Data.Relationships?
    
        /// (Required) The resource type.Value: users
        public let type: String = " users"
    }
}

/// MARK: UserUpdateRequest.Data
extension UserUpdateRequest.Data {
    /// Attributes that describe a resource.
    public struct Attributes: Codable {
    
        /// Assigned user roles that determine the user's access to sections of App Store Connect and tasks they can perform.
        public let allAppsVisible: Bool?
    
        /// A Boolean value that indicates the user's specified role allows access to the provisioning functionality on the Apple Developer website.
        public let provisioningAllowed: Bool?
    
        /// Assigned user roles that determine the user's access to sections of App Store Connect and tasks they can perform.
        public let roles: [UserRole]?
    }
    
    public struct Relationships: Codable {
    
        /// UserUpdateRequest.Data.Relationships.VisibleApps
        public let visibleApps: UserUpdateRequest.Data.Relationships.VisibleApps?
    }
}

/// MARK: UserUpdateRequest.Data.Relationships
extension UserUpdateRequest.Data.Relationships {
    
    public struct VisibleApps: Codable {
    
        /// [UserUpdateRequest.Data.Relationships.VisibleApps.Data]
        public let data: [UserUpdateRequest.Data.Relationships.VisibleApps.Data]?
    }
}

/// MARK: UserUpdateRequest.Data.Relationships.VisibleApps
extension UserUpdateRequest.Data.Relationships.VisibleApps {
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: apps
        public let type: String = " apps"
    }
}
