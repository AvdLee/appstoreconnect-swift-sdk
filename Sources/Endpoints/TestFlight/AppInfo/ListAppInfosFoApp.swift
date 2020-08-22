//
//  ListAppInfosFoApp.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Morten Bjerg Gregersen on 22/08/2020.
//

extension APIEndpoint where T == AppInfosResponse {
    
    /// Get information about an app that is currently live on App Store, or that goes live with the next version.
    ///
    /// - Parameters:
    ///   - id: An opaque resource ID that uniquely identifies the resource.
    ///   - fields: Fields to return for included related types.
    ///   - limit: Number of resources to return.
    ///   - next: The next URL to use as a base. See `PagedDocumentLinks`.
    public static func appInfos(
        forAppWithId id: String,
        fields: [ListAppInfosForApp.Field]? = nil,
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
            path: "apps/\(id)/appInfos",
            method: .get,
            parameters: parameters)
    }
}

public enum ListAppInfosForApp {
    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case appInfos([ListAppInfosForApp.Field.AppInfo])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .appInfos(let value):
                return (AppInfo.key, value.map { $0.pair.value }.joinedByCommas())
            }
        }
    }
}

extension ListAppInfosForApp.Field {
    public enum AppInfo: String, CaseIterable, NestableQueryParameter {
        case app, appInfoLocalizations, appStoreAgeRating, appStoreState, brazilAgeRating, kidsAgeBand, primaryCategory, primarySubcategoryOne, primarySubcategoryTwo, secondaryCategory, secondarySubcategoryOne, secondarySubcategoryTwo

        static var key: String = "appInfo"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}

public struct AppInfosResponse: Codable {
    /// The resource data.
    public let data: [AppInfo]
    
//    /// The requested relationship data.￼
//    ///  Possible types: BetaGroup, PrereleaseVersion, BetaAppLocalization, Build, BetaLicenseAgreement, BetaAppReviewDetail
//    public let included: [AppInfoRelationship]?
    
    /// Navigational links that include the self-link.
    public let links: PagedDocumentLinks
    
    /// Paging information.
    public let meta: PagingInformation?
}

public struct AppInfo: Codable {}
