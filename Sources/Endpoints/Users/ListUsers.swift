//
//  ListUsers.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == UsersResponse {

    /// Get a list of the users on your team.
    ///
    /// - Parameters:
    ///   - fields: Fields to return for included related types.
    ///   - include: Relationship data to include in the response.
    ///   - limit: Number of resources to return.
    ///   - sort: Attributes by which to sort.
    ///   - filter: Attributes, relationships, and IDs by which to filter.
    ///   - next: The next URL to use as a base. See `PagedDocumentLinks`.
    public static func users(
        fields: [ListUsers.Field]? = nil,
        include: [ListUsers.Include]? = nil,
        limit: [ListUsers.Limit]? = nil,
        sort: [ListUsers.Sort]? = nil,
        filter: [ListUsers.Filter]? = nil,
        next: PagedDocumentLinks? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let include = include { parameters.add(include) }
        if let limit = limit { parameters.add(limit) }
        if let sort = sort { parameters.add(sort) }
        if let filter = filter { parameters.add(filter) }
        if let nextCursor = next?.nextCursor { parameters["cursor"] = nextCursor }
        return APIEndpoint(path: "users", method: .get, parameters: parameters)
    }
}

public enum ListUsers {

    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case apps([App])
        case users([User])
        
        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .apps(let value):
                return (App.key, value.map({ $0.pair.value }).joinedByCommas())
            case .users(let value):
                return (User.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }
    
    /// Relationship data to include in the response.
    public enum Include: String, CaseIterable, NestableQueryParameter {
        case visibleApps

        static var key: String = "include"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    /// Number of resources to return.
    public enum Limit: NestableQueryParameter {
        case visibleApps(Int)

        static var key: String = "limit"
        var pair: Pair {
            switch self {
            case .visibleApps(let value):
                return ("visibleApps", "\(value)")
            }
        }
    }
    
    /// Attributes by which to sort.
    public enum Sort: String, CaseIterable, NestableQueryParameter {
        case lastNameAscending = "+lastName"
        case lastNameDescending = "-lastName"
        case usernameAscending = "+username"
        case usernameDescending = "-username"

        static var key: String = "sort"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    /// Attributes, relationships, and IDs by which to filter.
    public enum Filter: NestableQueryParameter {
        case roles([String]), visibleApps([String]), username([String])

        static var key: String = "filter"
        var pair: Pair {
            switch self {
            case .roles(let value):
                return ("roles", value.joinedByCommas())
            case .visibleApps(let value):
                return ("visibleApps", value.joinedByCommas())
            case .username(let value):
                return ("username", value.joinedByCommas())
            }
        }
    }
}

extension ListUsers.Field {
    
    public enum App: String, CaseIterable, NestableQueryParameter {
        case betaAppLocalizations, betaAppReviewDetail, betaGroups, betaLicenseAgreement, betaTesters, builds, bundleId, name, preReleaseVersions, primaryLocale, sku

        static var key: String = "app"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum User: String, CaseIterable, NestableQueryParameter {
        case allAppsVisible, firstName, lastName, provisioningAllowed, roles, username, visibleApps

        static var key: String = "user"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
