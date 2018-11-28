//
//  BetaTesterInvitation.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
public struct BetaTesterInvitation: Codable {

    /// The opaque resource ID that uniquely identifies the resource.
    public let `id`: String

    /// The resource type.Value: betaTesterInvitations
    public let type: String = "betaTesterInvitations"

    /// Navigational links that include the self-link.
    public let links: ResourceLinks<BetaTesterInvitationResponse>
}
