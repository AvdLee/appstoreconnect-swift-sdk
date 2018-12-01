//
//  ListPrereleaseVersions.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//
    
import Alamofire

extension APIEndpoint where T == PreReleaseVersionsResponse {

    /// Get a list of prerelease versions for all apps.
    ///
    /// - Parameters:
    ///   - fields: Fields to return for included related types.
    ///   - filter: Attributes, relationships, and IDs by which to filter.
    ///   - include: Relationship data to include in the response.
    ///   - limit: Number of resources to return.
    ///   - sort: Attributes by which to sort.
    public static func prereleaseVersions(
        fields: [ListPrereleaseVersions.Field]? = nil,
        filter: [ListPrereleaseVersions.Filter]? = nil,
        include: [ListPrereleaseVersions.Include]? = nil,
        limit: [ListPrereleaseVersions.Limit]? = nil,
        sort: [ListPrereleaseVersions.Sort]? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let filter = filter { parameters.add(filter) }
        if let include = include { parameters.add(include) }
        if let limit = limit { parameters.add(limit) }
        if let sort = sort { parameters.add(sort) }
        return APIEndpoint(path: "preReleaseVersions", method: .get, parameters: parameters)
    }
}

public struct ListPrereleaseVersions {
    
    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case apps([App])
        case builds([Build])
        case preReleaseVersions([PreReleaseVersion])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .apps(let value):
                return (App.key, value.map({ $0.pair.value }).joinedByCommas())
            case .builds(let value):
                return (Build.key, value.map({ $0.pair.value }).joinedByCommas())
            case .preReleaseVersions(let value):
                return (PreReleaseVersion.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }
    
    /// Attributes, relationships, and IDs by which to filter.
    public enum Filter: NestableQueryParameter {
        case app([String])
        case buildsExpired([String])
        case buildsProcessingState([BuildsProcessingState])
        case builds([String])
        case platform([String])
        case version([String])

        static var key: String = "filter"
        var pair: Pair {
            switch self {
            case .app(let value):
                return ("apps", value.joinedByCommas())
            case .buildsExpired(let value):
                return ("builds.expired", value.joinedByCommas())
            case .buildsProcessingState(let value):
                return (BuildsProcessingState.key, value.map({ $0.pair.value }).joinedByCommas())
            case .builds(let value):
                return ("builds", value.joinedByCommas())
            case .platform(let value):
                return ("platform", value.joinedByCommas())
            case .version(let value):
                return ("version", value.joinedByCommas())
            }
        }
    }
    
    /// Relationship data to include in the response.
    public enum Include: String, CaseIterable, NestableQueryParameter {
        case app, builds

        static var key: String = "include"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    /// Number of resources to return.
    public enum Limit: NestableQueryParameter {
        case builds(Int)

        static var key: String = "limit"
        var pair: Pair {
            switch self {
            case .builds(let value):
                return ("builds", "\(value)")
            }
        }

    }
    
    /// Attributes by which to sort.
    public enum Sort: String, CaseIterable, NestableQueryParameter {
        case versionAscending = "+version"
        case versionDescending = "-version"

        static var key: String = "sort"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}

extension ListPrereleaseVersions.Field {
    
    public enum App: String, CaseIterable, NestableQueryParameter {
        case betaAppLocalizations, betaAppReviewDetail, betaGroups, betaLicenseAgreement, betaTesters, builds, bundleId, name, preReleaseVersions, primaryLocale, sku

        static var key: String = "App"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum Build: String, CaseIterable, NestableQueryParameter {
        case app, appEncryptionDeclaration, betaAppReviewSubmission, betaBuildLocalizations, betaGroups, buildBetaDetail, expirationDate, expired, iconAssetToken, individualTesters, minOsVersion, preReleaseVersion, processingState, uploadedDate, usesNonExemptEncryption, version

        static var key: String = "build"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum PreReleaseVersion: String, CaseIterable, NestableQueryParameter {
        case app, builds, platform, version

        static var key: String = "preReleaseVersion"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}

extension ListPrereleaseVersions.Filter {
    
    public enum BuildsProcessingState: String, CaseIterable, NestableQueryParameter {
        case PROCESSING, FAILED, INVALID, VALID

        static var key: String = "builds.processingState"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
