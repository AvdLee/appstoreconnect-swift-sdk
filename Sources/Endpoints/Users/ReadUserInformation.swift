//
//  ReadUserInformation.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//
    

extension APIEndpoint where T == UserResponse {

    /// Get information about a user on your team, such as name, roles, and app visibility.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - fields: Fields to return for included related types.
    ///   - include: Relationship data to include in the response.
    ///   - limit: Number of included related resources to return.
    public static func user(
        withId id: String,
        fields: [ReadUserInformation.Field]? = nil,
        include: [ReadUserInformation.Include]? = nil,
        limit: [ReadUserInformation.Limit]? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let include = include { parameters.add(include) }
        if let limit = limit { parameters.add(limit) }
        return APIEndpoint(
            path: "users/\(id)",
            method: .get,
            parameters: parameters)
    }
}

public struct ReadUserInformation {
    
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
    
    /// Number of included related resources to return.
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
}

extension ReadUserInformation.Field {
    
    public enum App: String, CaseIterable, NestableQueryParameter {
        case betaAppLocalizations, betaAppReviewDetail, betaGroups, betaLicenseAgreement, betaTesters, builds, bundleId, name, preReleaseVersions, primaryLocale, sku

        static var key: String = "app"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum User: String, CaseIterable, NestableQueryParameter {
        case allAppsVisible, firstName, lastName, provisioningAllowed, roles, username, visibleApps

        static var key: String = "ser"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
