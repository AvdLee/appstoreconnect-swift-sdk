//
//  AppEncryptionDeclarationResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a single resource.
public struct AppEncryptionDeclarationResponse: Codable {

    /// The resource data.
    public let data: AppEncryptionDeclaration

    /// The requested relationship data.
    public let included: [App]?

    /// Navigational links that include the self-link.
    public let links: DocumentLinks
}
