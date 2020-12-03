//
//  CapabilitySettingKey.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/22/19.
//

import Foundation

/// Strings that represent a capability setting key.
public enum CapabilitySettingKey: String, Codable {
    case icloudVersion = "ICLOUD_VERSION"
    case dataProtectionPermissionLevel = "DATA_PROTECTION_PERMISSION_LEVEL"
    case appleIdAuthAppConsent = "APPLE_ID_AUTH_APP_CONSENT"
}
