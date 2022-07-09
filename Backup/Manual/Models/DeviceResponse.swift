//
//  DeviceResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/24/19.
//

import Foundation

/// A response containing a single resource.
public struct DeviceResponse: Codable {

    /// The resource data.
    public let data: Device

    /// Navigational links that include the self-link.
    public let links: DocumentLinks
}
