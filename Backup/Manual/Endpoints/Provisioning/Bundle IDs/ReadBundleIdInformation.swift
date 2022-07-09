//
//  ReadBundleIdInformation.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/23/19.
//

extension APIEndpoint where T == BundleIdResponse {

    /// Get information about a specific bundle ID.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the bundle identifier.
    ///   - fields: Fields to return for included related types.
    ///   - include: Relationship data to include in the response.
    ///   - limit: Number of resources to return.
    public static func readBundleIdInformation(
        id: String,
        fields: [BundleIds.Field]? = nil,
        include: [BundleIds.Include]? = nil,
        limit: Int? = nil) -> APIEndpoint {

        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let include = include { parameters.add(include) }
        if let limit = limit { parameters["limit"] = limit }

        return APIEndpoint(
            path: "bundleIds/\(id)",
            method: .get,
            parameters: parameters)
    }
}
