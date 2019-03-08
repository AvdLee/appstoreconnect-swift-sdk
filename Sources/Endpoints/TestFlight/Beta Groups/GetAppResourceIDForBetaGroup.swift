//
//  GetAppResourceIDForBetaGroup.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == BetaGroupAppLinkageResponse {

    /// Get the app resource ID for a specific beta group.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func appID(forBetaGroupWithId id: String) -> APIEndpoint {
        return APIEndpoint(path: "betaGroups/\(id)/relationships/app", method: .get, parameters: nil)
    }
}
