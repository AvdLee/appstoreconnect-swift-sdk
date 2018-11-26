//
//  RemoveBetaTester’sAccessToApps.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint {

    /// Remove a specific beta tester's access to test any builds of one or more apps.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func remove(
        betaTesterAccess: BetaTesterAppsLinkagesRequest,
        toAppWithId id: String) -> APIEndpoint<ErrorResponse> {
        return APIEndpoint<ErrorResponse>(
            path: "betaTesters/\(id)/relationships/apps",
            method: .delete,
            parameters: nil)
    }
}
