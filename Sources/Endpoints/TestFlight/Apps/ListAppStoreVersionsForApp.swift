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
    public static func appStoreVersions(
        ofAppWithId id: String,
        fields: [ListAppStoreVersionsOfApp.Field]? = nil,
        filters: [ListAppStoreVersionsOfApp.Filter]? = nil,
        limit: Int? = nil,
        next: PagedDocumentLinks? = nil
    ) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let filters = filters { parameters.add(filters) }
        if let limit = limit {
            parameters["limit"] = limit
        } else if let nextLimit = next?.nextLimit {
            parameters["limit"] = nextLimit
        }
        if let nextCursor = next?.nextCursor { parameters["cursor"] = nextCursor }
        return APIEndpoint(
            path: "apps/\(id)/appStoreVersions",
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

    /// Attributes, relationships, and IDs by which to filter.
    public enum Filter: NestableQueryParameter {
        case appStoreState([AppStoreVersionState])
        case platform([Platform])
        case versionString([String])

        static var key: String = "filter"
        var pair: Pair {
            switch self {
            case .appStoreState(let value):
                return ("appStoreState", value.map(\.rawValue).joinedByCommas())
            case .platform(let value):
                return ("platform", value.map(\.rawValue).joinedByCommas())
            case .versionString(let value):
                return ("versionString", value.joinedByCommas())
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
