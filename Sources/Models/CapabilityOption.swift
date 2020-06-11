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

    public init(
        description: String? = nil,
        enabled: Bool? = nil,
        enabledByDefault: Bool? = nil,
        key: CapabilityOptionKey? = nil,
        name: String? = nil,
        supportsWildcard: Bool? = nil
    ) {
        self.description = description
        self.enabled = enabled
        self.enabledByDefault = enabledByDefault
        self.key = key
        self.name = name
        self.supportsWildcard = supportsWildcard
    }
}
