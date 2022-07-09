//
//  CertificatesResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/14/19.
//

import Foundation

/// A response containing a list of resources.
public struct CertificatesResponse: Codable {

    /// The paging information details.
    public let data: [Certificate]

    /// Navigational links that include the self-link.
    public let links: PagedDocumentLinks

    /// Paging information.
    public let meta: PagingInformation?
}
