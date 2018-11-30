//
//  SendInvitationToBetaTester.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//
    
import Alamofire
import Foundation

extension APIEndpoint where T == BetaTesterInvitationResponse {

    /// Send or resend an invitation to a beta tester to test a specified app.
    ///
    /// - Parameters:
    ///   - appId: An opaque resource ID that uniquely identifies the resource.
    ///   - betaTesterId: An opaque resource ID that uniquely identifies the resource.
    public static func send(
        invitationForAppWithId appId: String,
        toBetaTesterWithId betaTesterId: String) -> APIEndpoint {
        let request = BetaTesterInvitationCreateRequest(appId: appId, betaTesterId: betaTesterId)
        return APIEndpoint(
            path: "betaTesterInvitations",
            method: .post,
            parameters: nil,
            body: try? JSONEncoder().encode(request))
    }
}
