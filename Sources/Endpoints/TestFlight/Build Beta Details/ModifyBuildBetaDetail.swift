//
//  ModifyBuildBetaDetail.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

import Foundation

extension APIEndpoint where Request == BuildBetaDetailUpdateRequest, Response == BuildBetaDetailResponse {

    /// Update beta test details for a specific build.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - autoNotifyEnabled: A Boolean value that enables you to send test invitations to users automatically when the build is available to external groups.
    public static func modify(
        buildBetaDetailWithId id: String,
        autoNotifyEnabled: Bool? = nil) -> APIEndpoint {
        let request = BuildBetaDetailUpdateRequest(id: id, autoNotifyEnabled: autoNotifyEnabled)
        return APIEndpoint(
            path: "buildBetaDetails/\(id)",
            method: .patch,
            parameters: nil,
            body: request)
    }
}
