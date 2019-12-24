//
//  CapabilityOption.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/22/19.
//

import Foundation

/// The data structure that represents the resource.
public struct CapabilityOption: Codable {

    public let description: String?

    public let enabled: Bool?

    public let enabledByDefault: Bool?

    public let key: CapabilityOptionKey?

    public let name: String?

    public let supportsWildcard: Bool?
}
