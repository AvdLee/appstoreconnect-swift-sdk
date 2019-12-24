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
}
