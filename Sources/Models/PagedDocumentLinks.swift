//
//  PagedDocumentLinks.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// Links related to the response document, including paging links.
struct PagedDocumentLinks: Decodable {

    /// The link to the first page of documents.
    let first: URL?

    /// The link to the next page of documents.
    let next: URL?

    /// (Required) The link that produced the current document.
    let `self`: URL
}
