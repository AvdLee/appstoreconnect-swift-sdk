//
//  GetAllProfileIdsForBundleId.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/23/19.
//

extension APIEndpoint where T == BundleIdProfilesLinkagesResponse {

    /// Get the resource IDs for all profiles associated with a specific bundle ID.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the bundle identifier.
    ///   - limit: Number of resources to return.
    public static func getAllProfileIdsForBundleId(
        id: String,
        limit: Int? = nil) -> APIEndpoint {

        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }

        return APIEndpoint(
            path: "bundleIds/\(id)/relationships/profiles",
            method: .get,
            parameters: parameters)
    }
}
