//
//  GetIDsOfBuildsAssignedToBetaTester.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint {

    /// Get a list of build resource IDs individually assigned to a specific beta tester.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - limit: Number of resources to return.
    public static func getIDsOfBuildsAssignedToBetaTester(
        withId id: String,
        limit: Int? = nil) -> APIEndpoint<BetaTesterBuildsLinkagesResponse> {
        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }
        return APIEndpoint<BetaTesterBuildsLinkagesResponse>(path: "betaTesters/\(id)/relationships/builds", method: .get, parameters: parameters)
    }
}
