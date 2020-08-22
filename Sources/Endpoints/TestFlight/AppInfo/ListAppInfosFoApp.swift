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

public struct AppInfosResponse: Codable {
    /// The resource data.
    public let data: [AppInfo]
    
    /// The requested relationship data.￼
    ///  Possible types: BetaGroup, PrereleaseVersion, BetaAppLocalization, Build, BetaLicenseAgreement, BetaAppReviewDetail
    public let included: [AppInfoRelationship]?
    
    /// Navigational links that include the self-link.
    public let links: PagedDocumentLinks
    
    /// Paging information.
    public let meta: PagingInformation?
}

/// The data structure that represents the resource.
public struct AppInfo: Codable {
    /// Attributes that describe a resource.
    public struct Attributes: Codable {
        public let appStoreAgeRating: AppStoreAgeRating
        public let appStoreState: AppStoreVersionState
        public let brazilAgeRating: BrazilAgeRating
        public let kidsAgeBand: KidsAgeBand
    }
    
    public struct Relationships: Codable {
//        public let app: AppInfo.Relationships.App?
//        public let appInfoLocalizations: AppInfo.Relationships.AppInfoLocalizations?
//        public let primaryCategory: AppInfo.Relationships.PrimaryCategory?
//        public let primarySubcategoryOne: AppInfo.Relationships.PrimarySubcategoryOne?
//        public let primarySubcategoryTwo: AppInfo.Relationships.PrimarySubcategoryTwo?
//        public let secondaryCategory: AppInfo.Relationships.SecondaryCategory?
//        public let secondarySubcategoryOne: AppInfo.Relationships.SecondarySubcategoryOne?
//        public let secondarySubcategoryTwo: AppInfo.Relationships.SecondarySubcategoryTwo?
    }
    
    /// The resource's attributes.
    public let attributes: AppInfo.Attributes?
    
    /// The opaque resource ID that uniquely identifies the resource.
    public let id: String
    
    /// Navigational links to related data and included resource types and IDs.
    public let relationships: AppInfo.Relationships?
    
    /// The resource type.Value: apps
    public let type: String = "appInfos"
    
//    /// Navigational links that include the self-link.
//    public let links: ResourceLinks<AppInfoResponse>
}

public enum AppInfoRelationship: Codable {
    case app(App)
//    case appInfoLocalizations([AppInfoLocalization])
//    case primaryCategory(AppCategory)
//    case primarySubcategoryOne(AppCategory)
//    case primarySubcategoryTwo(AppCategory)
//    case secondaryCategory(AppCategory)
//    case secondarySubcategoryOne(AppCategory)
//    case secondarySubcategoryTwo(AppCategory)
    
    enum TypeKeys: String, CodingKey {
        case type
    }
    
    enum CodingKeys: String, Decodable, CodingKey {
        case app, appInfoLocalizations, primaryCategory, primarySubcategoryOne, primarySubcategoryTwo, secondaryCategory, secondarySubcategoryOne, secondarySubcategoryTwo
    }
    
    public init(from decoder: Decoder) throws {
        let type = try decoder.container(keyedBy: TypeKeys.self).decode(CodingKeys.self, forKey: .type)
        switch type {
        case .app:
            self = try .app(App(from: decoder))
        default:
            fatalError()
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .app(let value):
            try value.encode(to: encoder)
        }
    }
}

public enum AppStoreAgeRating: String, Codable {
    case fourPlus = "FOUR_PLUS"
    case ninePlus = "NINE_PLUS"
    case twelvePlus = "TWELVE_PLUS"
    case seventeenPlus = "SEVENTEEN_PLUS"
}

public enum AppStoreVersionState: String, Codable {
    case developerRemovedFromSale = "DEVELOPER_REMOVED_FROM_SALE"
    case developerRejected = "DEVELOPER_REJECTED"
    case inReview = "IN_REVIEW"
    case invalidBinary = "INVALID_BINARY"
    case metadataRejected = "METADATA_REJECTED"
    case pendingAppleRelease = "PENDING_APPLE_RELEASE"
    case pendingContract = "PENDING_CONTRACT"
    case pendingDeveloperRelease = "PENDING_DEVELOPER_RELEASE"
    case prepareForSubmission = "PREPARE_FOR_SUBMISSION"
    case preorderReadyForSale = "PREORDER_READY_FOR_SALE"
    case processingForAppStore = "PROCESSING_FOR_APP_STORE"
    case readyForSale = "READY_FOR_SALE"
    case rejected = "REJECTED"
    case removedFromSale = "REMOVED_FROM_SALE"
    case waitingForExportCompliance = "WAITING_FOR_EXPORT_COMPLIANCE"
    case waitingForReview = "WAITING_FOR_REVIEW"
    case replacedWithNewVersion = "REPLACED_WITH_NEW_VERSION"
}

public enum BrazilAgeRating: String, Codable {
    case l = "L"
    case ten = "TEN"
    case twelve = "TWELVE"
    case fourteen = "FOURTEEN"
    case sixteen = "SIXTEEN"
    case eighteen = "EIGHTEEN"
}

public enum KidsAgeBand: String, Codable {
    case fiveAndUnder = "FIVE_AND_UNDER"
    case sixToEight = "SIX_TO_EIGHT"
    case nineToEleven = "NINE_TO_ELEVEN"
}
