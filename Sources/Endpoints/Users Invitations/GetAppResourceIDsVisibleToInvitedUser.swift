//
//  GetAppResourceIDsVisibleToInvitedUser.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == UserInvitationVisibleAppsLinkagesResponse {

    /// Get a list of app resource IDs that will be visible to a user with a pending invitation.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    
    ///   - limit: Number of resources to return.
    public static func appIDs(
        visibleToInvitedUserWithId id: String,
        limit: Int? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }
        return APIEndpoint(
            path: "userInvitations/\(id)/relationships/visibleApps",
            method: .get,
            parameters: parameters)
    }
}
