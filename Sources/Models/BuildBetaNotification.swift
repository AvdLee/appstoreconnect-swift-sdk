//
//  BuildBetaNotification.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
public struct BuildBetaNotification: Codable {

    /// (Required) The opaque resource ID that uniquely identifies the resource.
    public let `id`: String

    /// (Required) Navigational links that include the self-link.
    public let links: ResourceLinks<BuildBetaNotificationResponse>

    /// (Required) The resource type.Value: buildBetaNotifications
    public let type: String
}
