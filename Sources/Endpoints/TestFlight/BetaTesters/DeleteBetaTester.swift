//
//  DeleteBetaTester.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint where T == Void {

    /// Remove a beta tester's ability to test all apps.
    ///
    /// - Parameters:
    ///   - id: An opaque resource ID that uniquely identifies the resource.
    public static func delete(betaTesterWithId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "betaTesters/\(id)",
            method: .delete,
            parameters: nil)
    }
}
