//
//  Certificate.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/14/19.
//

import Foundation

/// The data structure that represents the resource.
public struct Certificate: Codable {
    
    /// Attributes that describe a certificate.
    public struct Attributes: Codable {
        public let certificateContent: String?
        public let displayName: String?
        public let expirationDate: Date?
        public let name: String?
        public let platform: BundleIdPlatform?
        public let serialNumber: String?
        public let certificateType: CertificateType?
    }
    
    /// The resource's attributes.
    public let attributes: Certificate.Attributes

    /// The opaque resource ID that uniquely identifies the resource.
    public let `id`: String

    /// The resource type.
    public private(set) var type: String = "certificates"

    /// Navigational links that include the self-link.
    public let links: PagedDocumentLinks
}
