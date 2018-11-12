//
//  BuildBetaNotification.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
struct BuildBetaNotification: Decodable {

    /// (Required) The opaque resource ID that uniquely identifies the resource.
    let `id`: String

    /// (Required) Navigational links that include the self-link.
    let links: ResourceLinks

    /// (Required) The resource type.Value: buildBetaNotifications
    let type: String

}
