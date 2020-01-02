//
//  ListAllCapabilitiesForBundleId.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/23/19.
//

extension APIEndpoint where T == BundleIdCapabilitiesResponse {

    /// Get a list of all capabilities for a specific bundle ID.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the bundle identifier.
    ///   - fields: Fields to return for included related types.
    ///   - limit: Number of resources to return.
    public static func listAllCapabilitiesForBundleId(
        id: String,
        fields: [BundleIds.Field]? = nil,
        limit: Int? = nil) -> APIEndpoint {

        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let limit = limit { parameters["limit"] = limit }

        return APIEndpoint(
            path: "bundleIds/\(id)/bundleIdCapabilities",
            method: .get,
            parameters: parameters)
    }
}
