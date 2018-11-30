//
//  GetBetaBuildLocalizationIDsOfBuild.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//
    
import Alamofire

extension APIEndpoint where T == BuildBetaBuildLocalizationsLinkagesResponse {

    /// Get a list of beta build localization resource IDs associated with a build.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - limit: Number of resources to return.
    public static func betaBuildLocalizationIDs(
        ofBuildWithId id: String,
        limit: Int? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }
        return APIEndpoint(
            path: "builds/\(id)/relationships/betaBuildLocalizations",
            method: .get,
            parameters: parameters)
    }
}
