//
//  BuildBetaNotificationCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
struct BuildBetaNotificationCreateRequest: Decodable {

    /// (Required) The resource data.
    let data: BuildBetaNotificationCreateRequest.Data

}

extension BuildBetaNotificationCreateRequest {
    
    struct Data: Decodable {
    
        /// (Required) The types and IDs of the related data to update.
        let relationships: BuildBetaNotificationCreateRequest.Data.Relationships
    
        /// (Required) The resource type.Value: buildBetaNotifications
        let type: String
    
    }
}

extension BuildBetaNotificationCreateRequest.Data {
    
    struct Relationships: Decodable {
    
        /// BuildBetaNotificationCreateRequest.Data.Relationships.Build (Required)
        let build: BuildBetaNotificationCreateRequest.Data.Relationships.Build
    
    }
}

extension BuildBetaNotificationCreateRequest.Data.Relationships {
    
    struct Build: Decodable {
    
        /// BuildBetaNotificationCreateRequest.Data.Relationships.Build.Data (Required)
        let data: BuildBetaNotificationCreateRequest.Data.Relationships.Build.Data
    
    }
}

extension BuildBetaNotificationCreateRequest.Data.Relationships.Build {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The types and IDs of the related data to update.Value: builds
        let type: String
    
    }
}
