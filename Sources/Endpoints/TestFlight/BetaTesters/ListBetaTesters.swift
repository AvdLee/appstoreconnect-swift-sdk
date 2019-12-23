//
//  ListBetaTesters.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//

extension APIEndpoint where T == BetaTestersResponse {

    /// Find and list beta testers for all apps, builds, and beta groups.
    ///
    /// - Parameters:
    ///   - fields: Fields to return for included related types.
    ///   - filter: Attributes, relationships, and IDs by which to filter.
    ///   - include: Relationship data to include in the response.
    ///   - limit: Number of resources to return.
    ///   - sort: Attributes by which to sort.
    ///   - next: The next URL to use as a base. See `PagedDocumentLinks`.
    public static func betaTesters(
        fields: [ListBetaTesters.Field]? = nil,
        filter: [ListBetaTesters.Filter]? = nil,
        include: [ListBetaTesters.Include]? = nil,
        limit: [ListBetaTesters.Limit]? = nil,
        sort: [ListBetaTesters.Sort]? = nil,
        next: PagedDocumentLinks? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let filter = filter { parameters.add(filter) }
        if let include = include { parameters.add(include) }
        if let limit = limit { parameters.add(limit) }
        if let sort = sort { parameters.add(sort) }
        if let nextCursor = next?.nextCursor { parameters["cursor"] = nextCursor }
        return APIEndpoint(path: "betaTesters", method: .get, parameters: parameters)
    }
}

public enum ListBetaTesters {
    
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
        case apps([String])
        case betaGroups([String])
        case builds([String])
        case email([String])
        case firstName([String])
        case inviteType([String])
        case lastName([String])

        static var key: String = "filter"
        var pair: Pair {
            switch self {
            case .apps(let value):
                return ("apps", value.joinedByCommas())
            case .betaGroups(let value):
                return ("betaGroups", value.joinedByCommas())
            case .builds(let value):
                return ("builds", value.joinedByCommas())
            case .email(let value):
                return ("email", value.joinedByCommas())
            case .firstName(let value):
                return ("firstName", value.joinedByCommas())
            case .inviteType(let value):
                return ("inviteType", value.joinedByCommas())
            case .lastName(let value):
                return ("lastName", value.joinedByCommas())
            }
        }
    }
    
    /// Relationship data to include in the response.
    public enum Include: String, CaseIterable, NestableQueryParameter {
        case apps, betaGroups, builds

        static var key: String = "include"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    /// Number of resources to return.
    public enum Limit: NestableQueryParameter {
        case betaTesters(Int)
        case apps(Int)
        case betaGroups(Int)
        case builds(Int)

        static var key: String = "limit"
        var pair: Pair {
            switch self {
            case .betaTesters(let value):
                return (nil, "\(value)")
            case .apps(let value):
                return ("apps", "\(value)")
            case .betaGroups(let value):
                return ("betaGroups", "\(value)")
            case .builds(let value):
                return ("builds", "\(value)")
            }
        }
    }
    
    /// Attributes by which to sort.
    public enum Sort: String, CaseIterable, NestableQueryParameter {
        case emailAscending = "+email"
        case emailDescending = "-email"
        
        case firstNameAscending = "+firstName"
        case firstNameDescending = "-firstName"
        
        case inviteTypeAscending = "+inviteType"
        case inviteTypeDescending = "-inviteType"
        
        case lastNameAscending = "+lastName"
        case lastNameDescending = "-lastName"

        static var key: String = "sort"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}

extension ListBetaTesters.Field {
    
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
