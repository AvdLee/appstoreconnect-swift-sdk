//
//  SendNotificationOfAvailableBuild.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

import Foundation
import Alamofire

extension APIEndpoint where T == BuildBetaNotificationResponse {

    /// Send a notification to all assigned beta testers that a build is available for testing.
    ///
    /// - Parameters:
    ///   - buildId: The opaque resource ID that uniquely identifies the resource.
    public static func send(notificationOfAvailableBuildWithId id: String) -> APIEndpoint {
        let request = BuildBetaNotificationCreateRequest(buildId: id)
        return APIEndpoint(
            path: "buildBetaNotifications",
            method: .post,
            parameters: nil,
            body: try? JSONEncoder().encode(request))
    }
}
