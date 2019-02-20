//
//  GetBetaTesterIDsInBetaGroup.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == BetaGroupBetaTestersLinkagesResponse {

    /// Get a list of the beta tester resource IDs in a specific beta group.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - limit: Number of resources to return.
    public static func betaTesterIDs(
        inBetaGroupWith id: String,
        limit: Int? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }
        return APIEndpoint(path: "betaGroups/\(id)/relationships/betaTesters", method: .get, parameters: parameters)
    }
}
