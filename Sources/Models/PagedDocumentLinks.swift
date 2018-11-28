//
//  PagedDocumentLinks.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// Links related to the response document, including paging links.
public struct PagedDocumentLinks: Codable {

    /// The link to the first page of documents.
    public let first: URL?

    /// The link to the next page of documents.
    public let next: URL?

    /// The link that produced the current document.
    public let `self`: URL
}
