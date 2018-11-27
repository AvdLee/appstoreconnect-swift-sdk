//
//  BetaGroupResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a single resource.
public struct BetaGroupResponse: Codable {

    /// (Required) The resource data.
    public let data: BetaGroup

    /// The requested relationship data.￼
    ///  Possible types: App, Build, BetaTester
    public let include: [BetaGroupRelationship]?

    /// (Required) Navigational links that include the self-link.
    public let links: DocumentLinks
}
