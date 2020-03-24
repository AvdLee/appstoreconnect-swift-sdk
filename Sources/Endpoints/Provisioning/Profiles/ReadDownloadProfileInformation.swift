//
//  ReadDownloadProfileInformation.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/24/19.
//

import Foundation

extension APIEndpoint where Request == EmptyBody, Response == ProfileResponse {

    /// Get information about a specific bundle ID.
    public static func readProfileInformation(
        id: String,
        fields: [Profiles.Field]? = nil,
        include: [Profiles.Include]? = nil,
        limit: [Profiles.Limit]? = nil) -> APIEndpoint {

        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let include = include { parameters.add(include) }
        if let limit = limit { parameters.add(limit) }

        return APIEndpoint(
            path: "profiles/\(id)",
            method: .get,
            parameters: parameters)
    }
}
