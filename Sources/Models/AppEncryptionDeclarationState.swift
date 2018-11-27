//
//  AppEncryptionDeclarationState.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    /// Strings representing the review or acceptance status of an app encryption declaration submitted to Apple.
public enum AppEncryptionDeclarationState: String, Codable {
    case approved = "APPROVED"
    case invalid = "INVALID"
    case expired = "EXPIRED"
    case inReview = "IN_REVIEW"
    case rejected = "REJECTED"
}
