//
//  GetBetaAppLocalizationIDsOfApp.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//

extension APIEndpoint where Request == EmptyBody, Response == AppBetaAppLocalizationsLinkagesResponse {

    /// Get a list of beta app localization resource IDs associated with a specific app.
    ///
    /// - Parameters:
    ///   - id: An opaque resource ID that uniquely identifies the resource.
    ///   - limit: Number of resources to return.
    public static func betaAppLocalizationIDs(ofAppWithId id: String, limit: Int? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }
        return APIEndpoint(
            path: "apps/\(id)/relationships/betaAppLocalizations",
            method: .get,
            parameters: parameters)
    }
}
