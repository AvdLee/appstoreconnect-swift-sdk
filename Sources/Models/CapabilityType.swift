//
//  CapabilityType.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/22/19.
//

import Foundation

/// Strings that represent a capability type.
public enum CapabilityType: String, Codable {
    case icloud = "ICLOUD"
    case inAppPurchase = "IN_APP_PURCHASE"
    case gameCenter = "GAME_CENTER"
    case pushNotifications = "PUSH_NOTIFICATIONS"
    case wallet = "WALLET"
    case interAppAudio = "INTER_APP_AUDIO"
    case maps = "MAPS"
    case associatedDomains = "ASSOCIATED_DOMAINS"
    case personalVpn = "PERSONAL_VPN"
    case appGroups = "APP_GROUPS"
    case healthkit = "HEALTHKIT"
    case homekit = "HOMEKIT"
    case wirelessAccessoryConfiguration = "WIRELESS_ACCESSORY_CONFIGURATION"
    case applePay = "APPLE_PAY"
    case dataProtection = "DATA_PROTECTION"
    case sirikit = "SIRIKIT"
    case networkExtensions = "NETWORK_EXTENSIONS"
    case multipath = "MULTIPATH"
    case hotSpot = "HOT_SPOT"
    case nfcTagReading = "NFC_TAG_READING"
    case classkit = "CLASSKIT"
    case autofillCredentialProvider = "AUTOFILL_CREDENTIAL_PROVIDER"
    case accessWifiInformation = "ACCESS_WIFI_INFORMATION"
}

