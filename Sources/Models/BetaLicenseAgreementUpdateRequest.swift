//
//  BetaLicenseAgreementUpdateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
public struct BetaLicenseAgreementUpdateRequest: Codable {

    /// - Parameters:
    ///   - id: The opaque resource ID that uniquely identifies the resource.
    ///   - agreementText: The license agreement text for your beta app that displays to users.
    init(id: String, agreementText: String? = nil) {
        data = .init(attributes: .init(agreementText: agreementText), id: id)
    }
    
    /// (Required) The resource data.
    public let data: BetaLicenseAgreementUpdateRequest.Data
    
    public struct Data: Codable {
    
        /// The resource's attributes.
        public let attributes: BetaLicenseAgreementUpdateRequest.Data.Attributes?
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: betaLicenseAgreements
        public let type: String = "betaLicenseAgreements"
    }
}

/// MARK: BetaLicenseAgreementUpdateRequest.Data
extension BetaLicenseAgreementUpdateRequest.Data {
    /// Attributes that describe a resource.
    public struct Attributes: Codable {
    
        /// The license agreement text for your beta app that displays to users.
        public let agreementText: String?
    }
}
