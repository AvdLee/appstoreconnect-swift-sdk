//
//  ListAppStoreVersionsForApp.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Morten Bjerg Gregersen on 02/09/2020.
//

extension APIEndpoint where T == AppStoreVersionsResponse {
    /// Get a list of app store versions associated with a specific app.
    ///
    /// - Parameters:
    ///   - id: An opaque resource ID that uniquely identifies the resource.
    ///   - fields: Fields to return for included related types.
    ///   - limit: Number of resources to return.
    ///   - next: The next URL to use as a base. See `PagedDocumentLinks`.
    public static func builds(
        ofAppWithId id: String,
        fields: [ListAppStoreVersionsOfApp.Field]? = nil,
        limit: Int? = nil,
        next: PagedDocumentLinks? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let limit = limit {
            parameters["limit"] = limit
        } else if let nextLimit = next?.nextLimit {
            parameters["limit"] = nextLimit
        }
        if let nextCursor = next?.nextCursor { parameters["cursor"] = nextCursor }
        return APIEndpoint(
            path: "apps/\(id)/builds",
            method: .get,
            parameters: parameters)
    }
}

public enum ListAppStoreVersionsOfApp {
    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case appStoreVersions([AppStoreVersion])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .appStoreVersions(let value):
                return (AppStoreVersion.key, value.map { $0.pair.value }.joinedByCommas())
            }
        }
    }
}

extension ListAppStoreVersionsOfApp.Field {
    public enum AppStoreVersion: String, CaseIterable, NestableQueryParameter {
        case ageRatingDeclaration, app, appStoreReviewDetail, appStoreState, appStoreVersionLocalizations, appStoreVersionPhasedRelease, appStoreVersionSubmission, build, copyright, createdDate, downloadable, earliestReleaseDate, idfaDeclaration, platform, releaseType, routingAppCoverage, usesIdfa, versionString

        static var key: String = "appStoreVersions"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
