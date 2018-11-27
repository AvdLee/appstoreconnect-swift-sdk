//
//  GetBetaLicenseAgreementIDForApp.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint where T == AppBetaLicenseAgreementLinkageResponse {

    /// Get a beta license agreement ID associated with a specific app.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func betaLicenseAgreementIDForApp(withId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "apps/\(id)/relationships/betaLicenseAgreement",
            method: .get,
            parameters: nil)
    }
}
