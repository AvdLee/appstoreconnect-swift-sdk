//
//  CapabilityTypeKey.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/22/19.
//

import Foundation

/// Strings that represent a capability option key.
public enum CapabilityOptionKey: String, Codable {
    case xcode5 = "XCODE_5"
    case xcode6 = "XCODE_6"
    case completeProtection = "COMPLETE_PROTECTION"
    case protectedUnlessOpen = "PROTECTED_UNLESS_OPEN"
    case protectedUntilFirstUserAuth = "PROTECTED_UNTIL_FIRST_USER_AUTH"
}
