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
        include relationships: [ListAppInfosForApp.Relationship]? = nil,
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
            path: "apps/\(id)/appInfos",
            method: .get,
            parameters: parameters)
    }
}

public enum ListAppInfosForApp {
    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case appInfos([AppInfo])
        case apps([App])
        case appInfoLocalizations([AppInfoLocalization])
        case appCategories([AppCategory])
        
        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .appInfos(let value):
                return (AppInfo.key, value.map { $0.pair.value }.joinedByCommas())
            case .apps(let value):
                return (App.key, value.map { $0.pair.value }.joinedByCommas())
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

extension ListAppInfosForApp.Field {
    public enum AppInfo: String, CaseIterable, NestableQueryParameter {
        case app, appInfoLocalizations, appStoreAgeRating, appStoreState, brazilAgeRating, kidsAgeBand, primaryCategory, primarySubcategoryOne, primarySubcategoryTwo, secondaryCategory, secondarySubcategoryOne, secondarySubcategoryTwo
        
        static var key: String = "appInfo"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum App: String, CaseIterable, NestableQueryParameter {
        case appInfos, appStoreVersions, availableInNewTerritories, availableTerritories, betaAppLocalizations, betaAppReviewDetail, betaGroups, betaLicenseAgreement, betaTesters, builds, bundleId, contentRightsDeclaration, endUserLicenseAgreement, gameCenterEnabledVersions, inAppPurchases, isOrEverWasMadeForKids, name, perfPowerMetrics, preOrder, preReleaseVersions, prices, primaryLocale, sku
        
        static var key: String = "apps"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum AppInfoLocalization: String, CaseIterable, NestableQueryParameter {
        case appInfo, locale, name, privacyPolicyText, privacyPolicyUrl, subtitle
        
        static var key: String = "appInfoLocalizations"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum AppCategory: String, CaseIterable, NestableQueryParameter {
        case parent, platforms, subcategories
        
        static var key: String = "appCategories"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
