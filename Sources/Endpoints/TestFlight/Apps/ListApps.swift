//
//  ListApps.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 16/11/2018.
//

extension APIEndpoint where T == AppsResponse {
    
    /// Find and list apps added in App Store Connect.
    ///
    /// - Parameters:
    ///   - fields: Fields to return for included related types.
    ///   - filters: Attributes, relationships, and IDs by which to filter.
    ///   - relationships: Relationship data to include in the response.
    ///   - sortBy: Attributes by which to sort.
    ///   - limits: Number of included related resources to return.
    ///   - next: The next URL to use as a base. See `PagedDocumentLinks`.
    public static func apps(
        select fields: [ListApps.Field]? = nil,
        filters: [ListApps.Filter]? = nil,
        include relationships: [ListApps.Relationship]? = nil,
        sortBy: [ListApps.Sorting]? = nil,
        limits: [ListApps.Limit]? = nil,
        next: PagedDocumentLinks? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let filters = filters { parameters.add(filters) }
        if let relationships = relationships { parameters.add(relationships) }
        if let sortBy = sortBy { parameters.add(sortBy) }
        if let limits = limits { parameters.add(limits) }
        if let nextCursor = next?.nextCursor { parameters["cursor"] = nextCursor }
        return APIEndpoint(path: "apps", method: .get, parameters: parameters)
    }
}

public enum ListApps {
    
    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case apps([App])
        case betaLicenseAgreements([BetaLicenseAgreement])
        case preReleaseVersions([PreReleaseVersion])
        case betaAppReviewDetails([BetaAppReviewDetail])
        case betaAppLocalizations([BetaAppLocalization])
        case builds([Build])
        case betaGroups([BetaGroup])
        
        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .apps(let value):
                return (App.key, value.map({ $0.pair.value }).joinedByCommas())
            case .betaLicenseAgreements(let value):
                return (BetaLicenseAgreement.key, value.map({ $0.pair.value }).joinedByCommas())
            case .preReleaseVersions(let value):
                return (PreReleaseVersion.key, value.map({ $0.pair.value }).joinedByCommas())
            case .betaAppReviewDetails(let value):
                return (BetaAppReviewDetail.key, value.map({ $0.pair.value }).joinedByCommas())
            case .betaAppLocalizations(let value):
                return (BetaAppLocalization.key, value.map({ $0.pair.value }).joinedByCommas())
            case .builds(let value):
                return (Build.key, value.map({ $0.pair.value }).joinedByCommas())
            case .betaGroups(let value):
                return (BetaGroup.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }
    
    /// Attributes, relationships, and IDs by which to filter.
    public enum Filter: NestableQueryParameter {
        case bundleId([String])
        case id([String])
        case name([String])
        case sku([String])
        
        static var key: String = "filter"
        var pair: Pair {
            switch self {
            case .bundleId(let value):
                return ("bundleId", value.joinedByCommas())
            case .id(let value):
                return ("id", value.joinedByCommas())
            case .name(let value):
                return ("name", value.joinedByCommas())
            case .sku(let value):
                return ("sku", value.joinedByCommas())
            }
        }
    }
    
    /// Relationship data to include in the response.
    public enum Relationship: String, CaseIterable, NestableQueryParameter {
        case betaAppLocalizations, betaAppReviewDetail, betaGroups, betaLicenseAgreement, builds, preReleaseVersions
        
        static var key: String = "include"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    /// Attributes by which to sort.
    public enum Sorting: String, CaseIterable, NestableQueryParameter {
        case bundleIdAscending = "+bundleId"
        case bundleIdDescending = "-bundleId"
        case nameAscending = "+name"
        case nameDescending = "-name"
        case skuAscending = "+sku"
        case skuDescending = "-sku"
        
        static var key: String = "sort"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    /// Number of included related resources to return.
    public enum Limit: NestableQueryParameter {
        
        /// Maximum: 200
        case apps(Int)
        
        /// Maximum: 50
        case preReleaseVersions(Int)
        
        /// Maximum: 50
        case builds(Int)
        
        /// Maximum: 50
        case betaGroups(Int)
        
        /// Maximum: 50
        case betaAppLocalizations(Int)
        
        static var key: String = "limit"
        var pair: Pair {
            switch self {
            case .apps(let value):
                return (nil, "\(value)")
            case .preReleaseVersions(let value):
                return ("preReleaseVersions", "\(value)")
            case .builds(let value):
                return ("builds", "\(value)")
            case .betaGroups(let value):
                return ("betaGroups", "\(value)")
            case .betaAppLocalizations(let value):
                return ("betaAppLocalizations", "\(value)")
            }
        }
    }
}

// MARK: - Field
extension ListApps.Field {
    public enum App: String, CaseIterable, NestableQueryParameter {
        case betaAppLocalizations, betaAppReviewDetail, betaGroups, betaLicenseAgreement, betaTesters, builds, bundleId, name, preReleaseVersions, primaryLocale, sku
        
        static var key: String = "apps"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum BetaLicenseAgreement: String, CaseIterable, NestableQueryParameter {
        case agreementText, app
        
        static var key: String = "betaLicenseAgreements"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum PreReleaseVersion: String, CaseIterable, NestableQueryParameter {
        case app, builds, platform, version
        
        static var key: String = "preReleaseVersions"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum BetaAppReviewDetail: String, CaseIterable, NestableQueryParameter {
        case app, contactEmail, contactFirstName, contactLastName, contactPhone, demoAccountName, demoAccountPassword, demoAccountRequired, notes
        
        static var key: String = "betaAppReviewDetails"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum BetaAppLocalization: String, CaseIterable, NestableQueryParameter {
        case app, description, feedbackEmail, locale, marketingUrl, privacyPolicyUrl, tvOsPrivacyPolicy
        
        static var key: String = "betaAppLocalizations"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum Build: String, CaseIterable, NestableQueryParameter {
        case app, appEncryptionDeclaration, betaAppReviewSubmission, betaBuildLocalizations, betaGroups, buildBetaDetail, expirationDate, expired, iconAssetToken, individualTesters, minOsVersion, preReleaseVersion, processingState, uploadedDate, usesNonExemptEncryption, version
        
        static var key: String = "builds"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum BetaGroup: String, CaseIterable, NestableQueryParameter {
        case app, betaTesters, builds, createdDate, isInternalGroup, name, publicLink, publicLinkEnabled, publicLinkId, publicLinkLimit, publicLinkLimitEnabled
        
        static var key: String = "betaGroups"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
