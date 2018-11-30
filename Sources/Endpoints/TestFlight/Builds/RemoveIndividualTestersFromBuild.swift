//
//  RemoveIndividualTestersFromBuild.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//
    
import Alamofire

extension APIEndpoint where T == Void {

    /// Remove access to test a specific build from one or more individually assigned testers.
    ///
    /// - Parameters:
    ///   - betaTesterIds: Array of opaque resource ID that uniquely identifies the resources.
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    public static func remove(
        individualTestersWithIds betaTesterIds: [String],
        fromBuildWithId id: String) -> APIEndpoint {
        let request = BuildIndividualTestersLinkagesRequest(betaTesterIds)
        return APIEndpoint(
            path: "builds/\(id)/relationships/individualTesters",
            method: .delete,
            parameters: nil,
            body: try? JSONEncoder().encode(request))
    }
}
