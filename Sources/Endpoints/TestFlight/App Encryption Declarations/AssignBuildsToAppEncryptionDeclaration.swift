//
//  AssignBuildsToAppEncryptionDeclaration.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//
    
import Alamofire
import Foundation

extension APIEndpoint where T == Void {

    /// Assign one or more builds to an app encryption declaration.
    ///
    /// - Parameters:
    ///   - buildIds: Array of opaque resource ID that uniquely identifies the resources.
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func assign(
        buildsWithIds buildIds: [String],
        toAppEncryptionDeclarationWithId id: String) -> APIEndpoint {
        let request = AppEncryptionDeclarationBuildsLinkagesRequest(buildIds)
        return APIEndpoint(
            path: "appEncryptionDeclarations/\(id)/relationships/builds",
            method: .post,
            parameters: nil,
            body: try? JSONEncoder().encode(request))
    }
}
