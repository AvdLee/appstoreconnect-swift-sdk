//
//  GetAppResourceIDForBetaAppLocalization.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//
    

extension APIEndpoint where T == BetaAppLocalizationAppLinkageResponse {

    /// Get the app resource ID for a specified beta app localization.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func appID(forBetaAppLocalizationWithId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "betaAppLocalizations/\(id)/relationships/app",
            method: .get,
            parameters: nil)
    }
}
