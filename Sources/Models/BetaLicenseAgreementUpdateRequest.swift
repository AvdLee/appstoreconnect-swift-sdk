//
//  BetaLicenseAgreementUpdateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
struct BetaLicenseAgreementUpdateRequest: Decodable {

    /// (Required) The resource data.
    let data: BetaLicenseAgreementUpdateRequest.Data
    
    struct Data: Decodable {
    
        /// The resource's attributes.
        let attributes: BetaLicenseAgreementUpdateRequest.Data.Attributes?
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: betaLicenseAgreements
        let type: String
    }
}

extension BetaLicenseAgreementUpdateRequest.Data {
    /// Attributes that describe a resource.
    struct Attributes: Decodable {
    
        /// The license agreement text for your beta app that displays to users.
        let agreementText: String?
    }
}
