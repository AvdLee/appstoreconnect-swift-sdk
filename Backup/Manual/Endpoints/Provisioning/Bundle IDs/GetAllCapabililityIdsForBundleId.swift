//
//  GetAllProfileIdsForBundleId.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/23/19.
//

extension APIEndpoint where T == BundleIdBundleIdCapabilitiesLinkagesResponse {

    /// Get the resource IDs for all capabilities associated with a specific bundle ID.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the bundle identifier.
    ///   - limit: Number of resources to return.
    public static func getAllCapabililityIdsForBundleId(
        id: String,
        limit: Int? = nil) -> APIEndpoint {

        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }

        return APIEndpoint(
            path: "bundleIds/\(id)/relationships/bundleIdCapabilities",
            method: .get,
            parameters: parameters)
    }
}
