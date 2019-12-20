//
//  CertificateType.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/14/19.
//

public enum CertificateType: String, Codable {
    case iOSDevelopment = "IOS_DEVELOPMENT"
    case iOSDistribution = "IOS_DISTRIBUTION"
    case macAppDistribution = "MAC_APP_DISTRIBUTION"
    case macInstallerDistribution = "MAC_INSTALLER_DISTRIBUTION"
    case macAppDevelopment = "MAC_APP_DEVELOPMENT"
    case developerIdKext = "DEVELOPER_ID_KEXT"
    case developerIdApplication = "DEVELOPER_ID_APPLICATION"
}
