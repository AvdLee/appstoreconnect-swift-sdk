//
//  RemoveBetaTesterAccessToApps.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//

import Foundation
import Alamofire

extension APIEndpoint where T == Void {

    /// Remove a specific beta tester's access to test any builds of one or more apps.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func remove(
        betaTesterAccess: BetaTesterAppsLinkagesRequest,
        toAppWithId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "betaTesters/\(id)/relationships/apps",
            method: .delete,
            parameters: nil,
            body: try? JSONEncoder().encode(betaTesterAccess))
    }
}
