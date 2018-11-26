//
//  ListPrereleaseVersionsForApp.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint {

    /// Get a list of prerelease versions associated with a specific app.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - limit: Number of resources to return.
    ///   - fields: Fields to return for included related types.
    public static func listPrereleaseVersionsForApp(
        withId id: String,
        limit: Int? = nil,
        fields: [ListPrereleaseVersionsForApp.Field]? = nil) -> APIEndpoint<PreReleaseVersionsResponse> {
        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }
        if let fields = fields { parameters.add(fields) }
        return APIEndpoint<PreReleaseVersionsResponse>(
            path: "apps/\(id)/preReleaseVersions",
            method: .get,
            parameters: parameters)
    }
}

public struct ListPrereleaseVersionsForApp {

    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case preReleaseVersions([PreReleaseVersion])
        
        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .preReleaseVersions(let value):
                return (PreReleaseVersion.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }
}

extension ListPrereleaseVersionsForApp.Field {
    
    public enum PreReleaseVersion: String, CaseIterable, NestableQueryParameter {
        case app, builds, platform, version

        static var key: String = "preReleaseVersion"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
