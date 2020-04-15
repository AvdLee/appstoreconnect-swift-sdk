//
//  BuildResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a single resource.
public struct BuildResponse: Codable {

    /// The resource data.
    public let data: Build

    /// The requested relationship data.￼
    ///  Possible types: PrereleaseVersion, BetaTester, BetaBuildLocalization, AppEncryptionDeclaration, BetaAppReviewSubmission, App, BuildBetaDetail
    public let included: [BuildRelationship]?

    /// Navigational links that include the self-link.
    public let links: DocumentLinks
}
