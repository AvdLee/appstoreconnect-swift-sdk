//
//  GetBetaLicenseAgreementIDForApp.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint {

    /// Get a beta license agreement ID associated with a specific app.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func getBetaLicenseAgreementIDForApp(withId id: String) -> APIEndpoint<AppBetaLicenseAgreementLinkageResponse> {
        return APIEndpoint<AppBetaLicenseAgreementLinkageResponse>(
            path: "apps/\(id)/relationships/betaLicenseAgreement",
            method: .get,
            parameters: nil)
    }
}
