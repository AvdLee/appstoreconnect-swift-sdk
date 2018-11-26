//
//  DeleteBetaTester.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint {

    /// Remove a beta tester's ability to test all apps.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func deleteBetaTester(withId id: String) -> APIEndpoint<ErrorResponse> {
        return APIEndpoint<ErrorResponse>(
            path: "betaTesters/\(id)",
            method: .delete,
            parameters: nil)
    }
}
