//
//  ModifyBuild.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//
    
import Alamofire

extension APIEndpoint where T == BuildResponse {

    /// Expire a build or change its encryption exemption setting.
    ///
    /// - Parameters:
    ///   - id: The opaque resource ID that uniquely identifies the resource.
    ///   - appEncryptionDeclarationId: The opaque resource ID that uniquely identifies the resource.
    ///   - autoNotifyEnabled: A Boolean value that enables you to send test invitations to users automatically when the build is available to external groups.
    public static func modify(
        buildWithId id: String,
        appEncryptionDeclarationId: String,
        expired: Bool? = nil,
        usesNonExemptEncryption: Bool? = nil) -> APIEndpoint {
        let request = BuildUpdateRequest(
            id: id,
            expired: expired,
            appEncryptionDeclarationId: appEncryptionDeclarationId,
            usesNonExemptEncryption: usesNonExemptEncryption)
        return APIEndpoint(
            path: "builds/\(id)",
            method: .patch,
            parameters: nil,
            body: try? JSONEncoder().encode(request))
    }
}
