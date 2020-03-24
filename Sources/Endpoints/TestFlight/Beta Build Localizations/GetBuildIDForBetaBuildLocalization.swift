//
//  GetBuildIDForBetaBuildLocalization.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where Request == EmptyBody, Response == BetaBuildLocalizationBuildLinkageResponse {

    /// Get a build resource ID for a specific beta build localization.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func buildID(forBetaBuildLocalizationWithId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "betaBuildLocalizations/\(id)/relationships/build",
            method: .get,
            parameters: nil)
    }
}
