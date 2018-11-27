//
//  CreateBetaTester.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint {

    /// Create a beta tester assigned to a group, a build, or an app.
    public static func create(
        betaTester: BetaTesterCreateRequest) -> APIEndpoint<BetaTesterResponse> {
        return APIEndpoint<BetaTesterResponse>(
            path: "betaTesters",
            method: .post,
            parameters: nil)
    }
}
