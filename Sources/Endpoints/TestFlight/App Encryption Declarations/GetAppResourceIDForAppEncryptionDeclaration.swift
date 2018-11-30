//
//  GetAppResourceIDForAppEncryptionDeclaration.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//
    
import Alamofire

extension APIEndpoint where T == AppEncryptionDeclarationAppLinkageResponse {

    /// Get the app resource ID associated with a specific app encryption declaration.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func appResourceID(forAppEncryptionDeclarationWithId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "appEncryptionDeclarations/\(id)/relationships/app",
            method: .get,
            parameters: nil)
    }
}
