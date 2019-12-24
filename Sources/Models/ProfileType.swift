//
//  ProfileType.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/22/19.
//

import Foundation

/// Strings that represent a profile type.
public enum ProfileType: String, Codable {
    case iOSAppDevelopment = "IOS_APP_DEVELOPMENT"
    case iOSAppStore = "IOS_APP_STORE"
    case iOSAppAdHoc = "IOS_APP_ADHOC"
    case iOSAppInHouse = "IOS_APP_INHOUSE"
    case macAppDevelopment = "MAC_APP_DEVELOPMENT"
    case macAppStore = "MAC_APP_STORE"
    case macAppDirect = "MAC_APP_DIRECT"
    case tvOSAppDevelopment = "TVOS_APP_DEVELOPMENT"
    case tvOSAppStore = "TVOS_APP_STORE"
    case tvOSAppAdHoc = "TVOS_APP_ADHOC"
    case tvOSAppInHouse = "TVOS_APP_INHOUSE"
}
