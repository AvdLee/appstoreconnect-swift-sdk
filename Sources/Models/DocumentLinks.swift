//
//  DocumentLinks.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// Self-links to documents that can contain information for one or more resources.
struct DocumentLinks: Decodable {

    /// (Required) The link that produced the current document.
    let `self`: URL
}
