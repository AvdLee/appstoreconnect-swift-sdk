//
//  GetResourceIDsOfIndividualTestersForBuild.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where Request == EmptyBody, Response == BuildIndividualTestersLinkagesResponse {

    /// Get a list of resource IDs of individual testers associated with a build.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - limit: Number of resources to return.
    public static func individualTestersIDs(
        ofForBuildWithId id: String,
        limit: Int? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }
        return APIEndpoint(
            path: "builds/\(id)/relationships/individualTesters",
            method: .get,
            parameters: parameters)
    }
}
