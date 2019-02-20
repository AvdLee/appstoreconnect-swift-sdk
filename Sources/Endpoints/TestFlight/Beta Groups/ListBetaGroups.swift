//
//  ListBetaGroups.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == BetaGroupsResponse {

    /// Find and list beta groups for all apps.
    ///
    /// - Parameters:
    ///   - fields: Fields to return for included related types.
    ///   - filter: Attributes, relationships, and IDs by which to filter.
    ///   - include: Relationship data to include in the response.
    ///   - limit: Number of resources to return.
    ///   - sort: Attributes by which to sort.
    ///   - next: The next URL to use as a base. See `PagedDocumentLinks`.
    public static func betaGroups(
        fields: [ListBetaGroups.Field]? = nil,
        filter: [ListBetaGroups.Filter]? = nil,
        include: [ListBetaGroups.Include]? = nil,
        limit: [ListBetaGroups.Limit]? = nil,
        sort: [ListBetaGroups.Sort]? = nil,
        next: PagedDocumentLinks? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let filter = filter { parameters.add(filter) }
        if let include = include { parameters.add(include) }
        if let limit = limit { parameters.add(limit) }
        if let sort = sort { parameters.add(sort) }
        if let nextCursor = next?.nextCursor { parameters["cursor"] = nextCursor }
        return APIEndpoint(path: "betaGroups", method: .get, parameters: parameters)
    }
}

public struct ListBetaGroups {

    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case apps([App])
        case betaGroups([BetaGroup])
        case betaTesters([BetaTester])
        case builds([Build])
        
        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .apps(let value):
                return (App.key, value.map({ $0.pair.value }).joinedByCommas())
            case .betaGroups(let value):
                return (BetaGroup.key, value.map({ $0.pair.value }).joinedByCommas())
            case .betaTesters(let value):
                return (BetaTester.key, value.map({ $0.pair.value }).joinedByCommas())
            case .builds(let value):
                return (Build.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }
    
    /// Attributes, relationships, and IDs by which to filter.
    public enum Filter: NestableQueryParameter {
        case app([String]), builds([String]), id([String]), isInternalGroup([String]), name([String]), publicLinkEnabled([String]), publicLinkLimitEnabled([String]), publicLink([String])

        static var key: String = "filter"
        var pair: Pair {
            switch self {
            case .app(let value):
                return ("app", value.joinedByCommas())
            case .builds(let value):
                return ("builds", value.joinedByCommas())
            case .id(let value):
                return ("id", value.joinedByCommas())
            case .isInternalGroup(let value):
                return ("isInternalGroup", value.joinedByCommas())
            case .name(let value):
                return ("name", value.joinedByCommas())
            case .publicLinkEnabled(let value):
                return ("publicLinkEnabled", value.joinedByCommas())
            case .publicLinkLimitEnabled(let value):
                return ("publicLinkLimitEnabled", value.joinedByCommas())
            case .publicLink(let value):
                return ("publicLink", value.joinedByCommas())
            }
        }
    }
    
    /// Relationship data to include in the response.
    public enum Include: String, CaseIterable, NestableQueryParameter {
        case app, betaTesters, builds

        static var key: String = "include"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    /// Number of resources to return.
    public enum Limit: NestableQueryParameter {
        case betaTesters(Int), builds(Int)
        
        static var key: String = "limit"
        var pair: Pair {
            switch self {
            case .betaTesters(let value):
                return ("betaTesters", "\(value)")
            case .builds(let value):
                return ("builds", "\(value)")
            }
        }
    }
    
    /// Attributes by which to sort.
    public enum Sort: String, CaseIterable, NestableQueryParameter {
        case createdDateAscending = "+createdDate"
        case createdDateDescending = "-createdDate"
        case nameAscending = "+name"
        case nameDescending = "-name"
        case publicLinkEnabledAscending = "+publicLinkEnabled"
        case publicLinkEnabledDescending = "-publicLinkEnabled"
        case publicLinkLimitAscending = "+publicLinkLimit"
        case publicLinkLimitDescending = "-publicLinkLimit"

        static var key: String = "sort"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}

extension ListBetaGroups.Field {
    
    public enum App: String, CaseIterable, NestableQueryParameter {
        case betaAppLocalizations, betaAppReviewDetail, betaGroups, betaLicenseAgreement, betaTesters, builds, bundleId, name, preReleaseVersions, primaryLocale, sku

        static var key: String = "app"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum BetaGroup: String, CaseIterable, NestableQueryParameter {
        case app, betaTesters, builds, createdDate, isInternalGroup, name, publicLink, publicLinkEnabled, publicLinkId, publicLinkLimit, publicLinkLimitEnabled

        static var key: String = "betaGroup"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum BetaTester: String, CaseIterable, NestableQueryParameter {
        case apps, betaGroups, builds, email, firstName, inviteType, lastName

        static var key: String = "betaTester"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum Build: String, CaseIterable, NestableQueryParameter {
        case app, appEncryptionDeclaration, betaAppReviewSubmission, betaBuildLocalizations, betaGroups, buildBetaDetail, expirationDate, expired, iconAssetToken, individualTesters, minOsVersion, preReleaseVersion, processingState, uploadedDate, usesNonExemptEncryption, version

        static var key: String = "build"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
