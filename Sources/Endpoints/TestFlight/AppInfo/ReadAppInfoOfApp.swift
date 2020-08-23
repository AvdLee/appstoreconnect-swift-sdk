//
//  File.swift
//
//
//  Created by Morten Bjerg Gregersen on 23/08/2020.
//

extension APIEndpoint where T == AppInfoResponse {
    /// Read App Store information including your App Store state, age ratings, Brazil age rating, and kids' age band.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - fields: Fields to return for included related types.
    public static func appInfo(
        forAppWithId id: String,
        fields: [AppInfoForApp.Field]? = nil,
        include relationships: [AppInfoForApp.Relationship]? = nil,
        limit: Int? = nil,
        next: PagedDocumentLinks? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let relationships = relationships { parameters.add(relationships) }
        if let limit = limit {
            parameters["limit"] = limit
        } else if let nextLimit = next?.nextLimit {
            parameters["limit"] = nextLimit
        }
        if let nextCursor = next?.nextCursor { parameters["cursor"] = nextCursor }
        return APIEndpoint(
            path: "appInfos/\(id)",
            method: .get,
            parameters: parameters)
    }
}

public enum AppInfoForApp {
    public enum Field: NestableQueryParameter {
        case appInfos([AppInfo])
        case appCategories([AppCategory])
        case appInfoLocalizations([AppInfoLocalization])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .appInfos(let value):
                return (AppInfo.key, value.map { $0.pair.value }.joinedByCommas())
            case .appInfoLocalizations(let value):
                return (AppInfoLocalization.key, value.map { $0.pair.value }.joinedByCommas())
            case .appCategories(let value):
                return (AppCategory.key, value.map { $0.pair.value }.joinedByCommas())
            }
        }
    }

    /// Relationship data to include in the response.
    public enum Relationship: String, CaseIterable, NestableQueryParameter {
        case app, appInfoLocalizations, primaryCategory, primarySubcategoryOne, primarySubcategoryTwo, secondaryCategory, secondarySubcategoryOne, secondarySubcategoryTwo

        static var key: String = "include"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}

extension AppInfoForApp.Field {
    public enum AppInfo: String, CaseIterable, NestableQueryParameter {
        case app, appInfoLocalizations, appStoreAgeRating, appStoreState, brazilAgeRating, kidsAgeBand, primaryCategory, primarySubcategoryOne, primarySubcategoryTwo, secondaryCategory, secondarySubcategoryOne, secondarySubcategoryTwo

        static var key: String = "appInfo"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    public enum AppCategory: String, CaseIterable, NestableQueryParameter {
        case parent, platforms, subcategories

        static var key: String = "appCategories"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    public enum AppInfoLocalization: String, CaseIterable, NestableQueryParameter {
        case appInfo, locale, name, privacyPolicyText, privacyPolicyUrl, subtitle

        static var key: String = "appInfoLocalizations"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
