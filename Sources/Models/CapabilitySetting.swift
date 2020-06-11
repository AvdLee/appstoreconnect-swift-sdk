//
//  CapabilitySetting.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/22/19.
//

import Foundation

/// The data structure that represents the resource.
public struct CapabilitySetting: Codable {
    public let allowedInstances: CapabilitySettingAllowedInstances?
    public let description: String?
    public let enabledByDefault: Bool?
    public let key: CapabilitySettingKey?
    public let name: String?
    public let options: [CapabilityOption]?
    public let visible: Bool?
    public let minInstances: Int?

    public init(
        allowedInstances: CapabilitySettingAllowedInstances? = nil,
        description: String? = nil,
        enabledByDefault: Bool? = nil,
        key: CapabilitySettingKey? = nil,
        name: String? = nil,
        options: [CapabilityOption]? = nil,
        visible: Bool? = nil,
        minInstances: Int? = nil
    ) {
        self.allowedInstances = allowedInstances
        self.description = description
        self.enabledByDefault = enabledByDefault
        self.key = key
        self.name = name
        self.options = options
        self.visible = visible
        self.minInstances = minInstances
    }
}
