//
//  RemoveBetaTestersFromGroupsAndBuildsOfApp.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint {

    /// Remove one or more beta testers' access to test any builds of a specific app.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func remove(
        betaTesters: AppBetaTestersLinkagesRequest,
        fromGroupsAndBuildsOfAppWithId id: String) -> APIEndpoint<Void> {
        return APIEndpoint<Void>(
            path: "apps/\(id)/relationships/betaTesters",
            method: .delete,
            parameters: ["AppBetaTestersLinkagesRequest": betaTesters])
    }
}
