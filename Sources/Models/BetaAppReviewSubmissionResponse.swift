//
//  BetaAppReviewSubmissionResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a single resource.
public struct BetaAppReviewSubmissionResponse: Decodable {

    /// (Required) The resource data.
    public let data: BetaAppReviewSubmission

    /// The requested relationship data.
    public let include: [Build]?

    /// (Required) Navigational links that include the self-link.
    public let links: DocumentLinks
}
