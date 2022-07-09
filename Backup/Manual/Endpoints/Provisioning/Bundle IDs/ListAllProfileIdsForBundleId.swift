//
//  GetAllProfileIdsForBundleId.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/23/19.
//

extension APIEndpoint where T == ProfilesResponse {

    /// Get a list of all profiles for a specific bundle ID.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the bundle identifier.
    ///   - fields: Fields to return for included related types.
    ///   - limit: Number of resources to return.
    public static func listAllProfilesForBundleId(
        id: String,
        fields: [BundleIds.Field]? = nil,
        limit: Int? = nil) -> APIEndpoint {

        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let limit = limit { parameters["limit"] = limit }

        return APIEndpoint(
            path: "bundleIds/\(id)/profiles",
            method: .get,
            parameters: parameters)
    }
}
