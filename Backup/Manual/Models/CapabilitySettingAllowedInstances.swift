//
//  CapabilitySettingAllowedInstances.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/22/19.
//

import Foundation

/// Strings that represent a capability setting allowed instances.
public enum CapabilitySettingAllowedInstances: String, Codable {
    case entry = "ENTRY"
    case single = "SINGLE"
    case multiple = "MULTIPLE"
}
