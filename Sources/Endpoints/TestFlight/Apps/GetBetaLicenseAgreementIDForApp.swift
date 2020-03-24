//
//  GetBetaLicenseAgreementIDForApp.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//

extension APIEndpoint where Request == EmptyBody, Response == AppBetaLicenseAgreementLinkageResponse {

    /// Get a beta license agreement ID associated with a specific app.
    ///
    /// - Parameters:
    ///   - id: An opaque resource ID that uniquely identifies the resource.
    public static func betaLicenseAgreementID(forAppWithId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "apps/\(id)/relationships/betaLicenseAgreement",
            method: .get,
            parameters: nil)
    }
}
