//
//  BuildBetaDetailResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a single resource.
public struct BuildBetaDetailResponse: Decodable {

    /// (Required) The resource data.
    public let data: BuildBetaDetail

    /// The requested relationship data.
    public let include: [Build]?

    /// (Required) Navigational links that include the self-link.
    public let links: DocumentLinks
}
