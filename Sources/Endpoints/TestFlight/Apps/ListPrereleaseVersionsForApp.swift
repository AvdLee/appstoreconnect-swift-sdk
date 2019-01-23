//
//  ListPrereleaseVersionsForApp.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    

extension APIEndpoint where T == PreReleaseVersionsResponse {

    /// Get a list of prerelease versions associated with a specific app.
    ///
    /// - Parameters:
    ///   - id: An opaque resource ID that uniquely identifies the resource.
    ///   - fields: Fields to return for included related types.
    ///   - limit: Number of resources to return.
    ///   - next: The next URL to use as a base. See `PagedDocumentLinks`.
    public static func prereleaseVersions(
        forAppWithId id: String,
        fields: [ListPrereleaseVersionsForApp.Field]? = nil,
        limit: Int? = nil,
        next: PagedDocumentLinks? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let limit = limit { parameters["limit"] = limit }
        if let nextCursor = next?.nextCursor { parameters["cursor"] = nextCursor }
        return APIEndpoint(
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
