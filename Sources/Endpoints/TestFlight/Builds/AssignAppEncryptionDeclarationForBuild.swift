//
//  AssignAppEncryptionDeclarationForBuild.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

import Foundation
import Alamofire

extension APIEndpoint where T == Void {

    /// Assign an app encryption declaration to a build.
    ///
    /// - Parameters:
    ///   - appEncryptionDeclarationId: The of opaque resource ID that uniquely identifies the resource.
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func assign(
        appEncryptionDeclarationWithId appEncryptionDeclarationId: String,
        toBuildWithId id: String) -> APIEndpoint {
        let request = BuildAppEncryptionDeclarationLinkageRequest(appEncryptionDeclarationId)
        return APIEndpoint(
            path: "builds/\(id)/relationships/appEncryptionDeclaration",
            method: .patch,
            parameters: nil,
            body: try? JSONEncoder().encode(request))
    }
}
