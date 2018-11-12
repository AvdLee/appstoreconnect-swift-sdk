//
//  UserRole.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    /// Strings representing user roles in App Store Connect.
enum UserRole: String, Decodable {
    case admin = "ADMIN"
    case finance = "FINANCE"
    case technical = "TECHNICAL"
    case sales = "SALES"
    case marketing = "MARKETING"
    case developer = "DEVELOPER"
    case accountHolder = "ACCOUNT_HOLDER"
    case readOnly = "READ_ONLY"
    case appManager = "APP_MANAGER"
    case accessToReports = "ACCESS_TO_REPORTS"
    case customerSupport = "CUSTOMER_SUPPORT"
}
