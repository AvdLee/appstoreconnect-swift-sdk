//
//  Platform.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation

/// Strings that represent Apple operating systems.
public enum Platform: String, Codable, CaseIterable {
    case ios = "IOS"
    case macOs = "MAC_OS"
    case tvOs = "TV_OS"
    case watchOs = "WATCH_OS"
}
