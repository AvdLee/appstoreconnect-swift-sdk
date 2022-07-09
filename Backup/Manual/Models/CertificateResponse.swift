//
//  CertificateResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/15/19.
//

import Foundation

/// A response containing a single resource.
public struct CertificateResponse: Codable {

    /// The resource data.
    public let data: Certificate

    /// Navigational links that include the self-link.
    public let links: PagedDocumentLinks
}
