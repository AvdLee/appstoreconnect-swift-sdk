//
//  AssignBetaTesterToBuilds.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint {

    /// Individually assign a beta tester to a build.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func assign(
        betaTester: BetaTesterBuildsLinkagesRequest,
        toBuildWithId id: String) -> APIEndpoint<ErrorResponse> {
        return APIEndpoint<ErrorResponse>(path: "betaTesters/\(id)/relationships/builds",
            method: .post,
            parameters: nil)
    }
}
