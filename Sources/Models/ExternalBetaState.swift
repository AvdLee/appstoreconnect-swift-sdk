//
//  ExternalBetaState.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    /// String that represents a build's availability for external testing.
enum ExternalBetaState: String, Decodable {
    case processing = "PROCESSING"
    case processingException = "PROCESSING_EXCEPTION"
    case missingExportCompliance = "MISSING_EXPORT_COMPLIANCE"
    case readyForBetaTesting = "READY_FOR_BETA_TESTING"
    case inBetaTesting = "IN_BETA_TESTING"
    case expired = "EXPIRED"
    case readyForBetaSubmission = "READY_FOR_BETA_SUBMISSION"
    case inExportComplianceReview = "IN_EXPORT_COMPLIANCE_REVIEW"
    case waitingForBetaReview = "WAITING_FOR_BETA_REVIEW"
    case inBetaReview = "IN_BETA_REVIEW"
    case betaRejected = "BETA_REJECTED"
    case betaApproved = "BETA_APPROVED"
}
