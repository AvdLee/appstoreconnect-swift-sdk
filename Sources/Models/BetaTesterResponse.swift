//
//  BetaTesterResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a single resource.
public struct BetaTesterResponse: Codable {

    /// The resource data.
    public let data: BetaTester

    /// The requested relationship data.￼
    ///  Possible types: App, BetaGroup, Build
    public let included: [BetaTesterRelationship]?

    /// Navigational links that include the self-link.
    public let links: DocumentLinks
}
