//
//  GetAppResourceIDForBetaLicenseAgreement.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == BetaLicenseAgreementAppLinkageResponse {

    /// Get the app resource ID for a specific beta license agreement.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func appID(forBetaLicenseAgreementWithId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "betaLicenseAgreements/\(id)/relationships/app",
            method: .get,
            parameters: nil)
    }
}
