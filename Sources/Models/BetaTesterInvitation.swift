//
//  BetaTesterInvitation.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
public struct BetaTesterInvitation: Decodable {

    /// (Required) The opaque resource ID that uniquely identifies the resource.
    public let `id`: String

    /// (Required) The resource type.Value: betaTesterInvitations
    public let type: String

    /// (Required) Navigational links that include the self-link.
    public let links: ResourceLinks<BetaTesterInvitationResponse>
}
