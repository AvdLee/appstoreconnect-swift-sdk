//
//  BetaReviewState.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation

public enum BetaReviewState: String, Decodable {
    case waitingForReview = "WAITING_FOR_REVIEW"
    case inReview = "IN_REVIEW"
    case rejected = "REJECTED"
    case approved = "APPROVED"
}
