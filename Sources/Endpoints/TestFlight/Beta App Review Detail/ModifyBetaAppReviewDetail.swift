//
//  ModifyBetaAppReviewDetail.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//
    
import Alamofire

extension APIEndpoint where T == BetaAppReviewDetailResponse {

    /// Update the details for a specific app's beta app review.
    ///
    /// - Parameters:
    ///   - id: The opaque resource ID that uniquely identifies the resource.
    ///   - contactEmail: Email address of contact in case communication is needed with the beta app review.
    ///   - contactFirstName: First name of contact in case communication is needed with the beta app review.
    ///   - contactLastName: Last name of contact in case communication is needed with the beta app review.
    ///   - contactPhone: Phone number of contact in case communication is needed with the beta app review.
    ///   - demoAccountName: The user name to sign in to your app to review its features.
    ///   - demoAccountPassword: The password to sign in to your app to review its features.
    ///   - demoAccountRequired: A Boolean value that indicates if sign-in information is required to review all the features of your app. If users sign in using social media, provide information for an account for review. Credentials must be valid and active for duration of review.
    ///   - notes: Additional information about your app that can help during the review process. Do not include demo account details. Review notes have a maximum of 4,000 characters.
    public static func modify(
        betaAppReviewDetailWithId id: String,
        contactEmail: String? = nil,
        contactFirstName: String? = nil,
        contactLastName: String? = nil,
        contactPhone: String? = nil,
        demoAccountName: String? = nil,
        demoAccountPassword: String? = nil,
        demoAccountRequired: Bool? = nil,
        notes: String? = nil) -> APIEndpoint {
        let request = BetaAppReviewDetailUpdateRequest(
            id: id,
            contactEmail: contactEmail,
            contactFirstName: contactFirstName,
            contactLastName: contactLastName,
            contactPhone: contactPhone,
            demoAccountName: demoAccountName,
            demoAccountPassword: demoAccountPassword,
            demoAccountRequired: demoAccountRequired,
            notes: notes)
        return APIEndpoint(
            path: "betaAppReviewDetails/\(id)",
            method: .patch,
            parameters: nil,
            body: try? JSONEncoder().encode(request))
    }
}
