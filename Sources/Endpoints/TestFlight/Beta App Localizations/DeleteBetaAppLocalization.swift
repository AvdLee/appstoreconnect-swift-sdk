//
//  DeleteBetaAppLocalization.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//
    
import Alamofire

extension APIEndpoint where T == Void {

    /// Delete a beta app localization associated with an app.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func delete(betaAppLocalizationWithId id: String) -> APIEndpoint {
        return APIEndpoint(path: "betaAppLocalizations/\(id)", method: .delete, parameters: nil)
    }
}
