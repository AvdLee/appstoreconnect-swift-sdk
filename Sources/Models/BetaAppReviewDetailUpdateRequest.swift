//
//  BetaAppReviewDetailUpdateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
struct BetaAppReviewDetailUpdateRequest: Decodable {

    /// (Required) The resource data.
    let data: BetaAppReviewDetailUpdateRequest.Data
    
    struct Data: Decodable {
    
        /// The resource's attributes.
        let attributes: BetaAppReviewDetailUpdateRequest.Data.Attributes?
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: betaAppReviewDetails
        let type: String
    }
}

extension BetaAppReviewDetailUpdateRequest.Data {
    /// Attributes that describe a resource.
    struct Attributes: Decodable {
    
        /// Email address of contact in case communication is needed with the beta app review.
        let contactEmail: String?
    
        /// First name of contact in case communication is needed with the beta app review.
        let contactFirstName: String?
    
        /// Last name of contact in case communication is needed with the beta app review.
        let contactLastName: String?
    
        /// Phone number of contact in case communication is needed with the beta app review.
        let contactPhone: String?
    
        /// The user name to sign in to your app to review its features.
        let demoAccountName: String?
    
        /// The password to sign in to your app to review its features.
        let demoAccountPassword: String?
    
        /// A Boolean value that indicates if sign-in information is required to review all the features of your app. If users sign in using social media, provide information for an account for review. Credentials must be valid and active for duration of review.
        let demoAccountRequired: Bool?
    
        /// Additional information about your app that can help during the review process. Do not include demo account details. Review notes have a maximum of 4,000 characters.
        let notes: String?
    }
}
