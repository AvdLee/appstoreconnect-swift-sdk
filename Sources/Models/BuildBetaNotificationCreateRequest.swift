//
//  BuildBetaNotificationCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
public struct BuildBetaNotificationCreateRequest: Decodable {

    /// (Required) The resource data.
    public let data: BuildBetaNotificationCreateRequest.Data
    
    public struct Data: Decodable {
    
        /// (Required) The types and IDs of the related data to update.
        public let relationships: BuildBetaNotificationCreateRequest.Data.Relationships
    
        /// (Required) The resource type.Value: buildBetaNotifications
        public let type: String
    }
}

/// MARK: BuildBetaNotificationCreateRequest.Data
extension BuildBetaNotificationCreateRequest.Data {
    
    public struct Relationships: Decodable {
    
        /// BuildBetaNotificationCreateRequest.Data.Relationships.Build (Required)
        public let build: BuildBetaNotificationCreateRequest.Data.Relationships.Build
    }
}

/// MARK: BuildBetaNotificationCreateRequest.Data.Relationships
extension BuildBetaNotificationCreateRequest.Data.Relationships {
    
    public struct Build: Decodable {
    
        /// BuildBetaNotificationCreateRequest.Data.Relationships.Build.Data (Required)
        public let data: BuildBetaNotificationCreateRequest.Data.Relationships.Build.Data
    }
}

/// MARK: BuildBetaNotificationCreateRequest.Data.Relationships.Build
extension BuildBetaNotificationCreateRequest.Data.Relationships.Build {
    
    public struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The types and IDs of the related data to update.Value: builds
        public let type: String
    }
}
