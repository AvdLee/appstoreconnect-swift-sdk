//
//  GetAppEncryptionDeclarationIDForBuild.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//
    

extension APIEndpoint where T == BuildAppEncryptionDeclarationLinkageResponse {

    /// Get the beta app encryption declaration resource ID associated with a build.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func appEncryptionDeclarationID(forBuildWithId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "builds/\(id)/relationships/appEncryptionDeclaration",
            method: .get,
            parameters: nil)
    }
}
