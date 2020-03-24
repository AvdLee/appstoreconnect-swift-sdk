//
//  ModifyBetaLicenseAgreement.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

import Foundation

extension APIEndpoint where Request == BetaLicenseAgreementUpdateRequest, Response == BetaLicenseAgreementResponse {

    /// Update the text for your beta license agreement.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - agreementText: The license agreement text for your beta app that displays to users.
    public static func modify(
        betaLicenseAgreementWithId id: String,
        agreementText: String? = nil) -> APIEndpoint {
        let request = BetaLicenseAgreementUpdateRequest(id: id, agreementText: agreementText)
        return APIEndpoint(
            path: "betaLicenseAgreements/\(id)",
            method: .patch,
            parameters: nil,
            body: request)
    }
}
