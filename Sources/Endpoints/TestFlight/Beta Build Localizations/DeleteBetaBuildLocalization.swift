//
//  DeleteBetaBuildLocalization.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where Request == EmptyBody, Response == IrrelevantResponse {

    /// Delete a specific beta build localization associated with a build.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func delete(betaBuildLocalizationWithId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "betaBuildLocalizations/\(id)",
            method: .delete,
            parameters: nil)
    }
}
