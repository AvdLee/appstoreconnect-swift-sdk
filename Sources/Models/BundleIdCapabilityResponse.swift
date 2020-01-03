//
//  BundleIdCapabilityResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/22/19.
//

import Foundation


/// The data structure that represents the resource.
public struct BundleIdCapabilityResponse: Codable {

    /// The resource data.
    public let data: BundleIdCapability?

    /// Navigational links that include the self-link.
    public let links: DocumentLinks
}
