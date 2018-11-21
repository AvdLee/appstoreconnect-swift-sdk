//
//  ListApps.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 16/11/2018.
//

import Alamofire

extension APIEndpoint {
    
    /// Find and list apps added in App Store Connect.
    ///
    /// - Parameters:
    ///   - fields: Fields to return for included related types.
    ///   - filters: Attributes, relationships, and IDs by which to filter.
    ///   - relationships: Relationship data to include in the response.
    ///   - sortBy: Attributes by which to sort.
    ///   - limits: Number of included related resources to return.
    public static func apps(
        select fields: [ListApps.Field]? = nil,
        filters: [ListApps.Filter]? = nil,
        include relationships: [ListApps.Relationship]? = nil,
        sortBy: [Sorting<ListApps.SortableField>]? = nil,
        limits: [ListApps.Limit]? = nil) -> APIEndpoint<AppsResponse>
    {
        var parameters = [String: Any]()
        if let fields = fields { parameters.merge(with: fields) }
        if let filters = filters { parameters.merge(with: filters) }
        if let relationships = relationships { parameters.merge(with: relationships) }
        if let sortBy = sortBy { parameters.merge(with: sortBy) }
        if let limits = limits { parameters.merge(with: limits) }
        return APIEndpoint<AppsResponse>(path: "apps", method: .get, parameters: parameters)
    }
}

public struct ListApps {
    
    /// Fields to return for included related types.
    public enum Field: NestableParameter {
        case apps([Apps])
        case betaLicenseAgreements([BetaLicenseAgreements])
        case preReleaseVersions([PreReleaseVersions])
        case betaAppReviewDetails([BetaAppReviewDetails])
        case betaAppLocalizations([BetaAppLocalizations])
        case builds([Builds])
        case betaGroups([BetaGroups])
        
        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .apps(let value):
                return ("apps", value.map({ $0.rawValue }).joined(separator: ","))
            case .betaLicenseAgreements(let value):
                return ("betaLicenseAgreements", value.map({ $0.rawValue }).joined(separator: ","))
            case .preReleaseVersions(let value):
                return ("preReleaseVersions", value.map({ $0.rawValue }).joined(separator: ","))
            case .betaAppReviewDetails(let value):
                return ("betaAppReviewDetails", value.map({ $0.rawValue }).joined(separator: ","))
            case .betaAppLocalizations(let value):
                return ("betaAppLocalizations", value.map({ $0.rawValue }).joined(separator: ","))
            case .builds(let value):
                return ("builds", value.map({ $0.rawValue }).joined(separator: ","))
            case .betaGroups(let value):
                return ("betaGroups", value.map({ $0.rawValue }).joined(separator: ","))
            }
        }
        
        public enum Apps: String, CaseIterable {
            case betaAppLocalizations, betaAppReviewDetail, betaGroups, betaLicenseAgreement, betaTesters, builds, bundleId, name, preReleaseVersions, primaryLocale, sku
        }
        
        public enum BetaLicenseAgreements: String, CaseIterable {
            case agreementText, app
        }
        
        public enum PreReleaseVersions: String, CaseIterable {
            case app, builds, platform, version
        }
        
        public enum BetaAppReviewDetails: String, CaseIterable {
            case app, contactEmail, contactFirstName, contactLastName, contactPhone, demoAccountName, demoAccountPassword, demoAccountRequired, notes
        }
        
        public enum BetaAppLocalizations: String, CaseIterable {
            case app, description, feedbackEmail, locale, marketingUrl, privacyPolicyUrl, tvOsPrivacyPolicy
        }
        
        public enum Builds: String, CaseIterable {
            case app, appEncryptionDeclaration, betaAppReviewSubmission, betaBuildLocalizations, betaGroups, buildBetaDetail, expirationDate, expired, iconAssetToken, individualTesters, minOsVersion, preReleaseVersion, processingState, uploadedDate, usesNonExemptEncryption, version
        }
        
        public enum BetaGroups: String, CaseIterable {
            case app, betaTesters, builds, createdDate, isInternalGroup, name, publicLink, publicLinkEnabled, publicLinkId, publicLinkLimit, publicLinkLimitEnabled
        }
    }
    
    /// Attributes, relationships, and IDs by which to filter.
    public enum Filter: NestableParameter {
        case bundleId([String])
        case id([String])
        case name([String])
        case sku([String])
        
        static var key: String = "filter"
        var pair: Pair {
            switch self {
            case .bundleId(let value):
                return ("bundleId", value.joined(separator: ","))
            case .id(let value):
                return ("id", value.joined(separator: ","))
            case .name(let value):
                return ("name", value.joined(separator: ","))
            case .sku(let value):
                return ("sku", value.joined(separator: ","))
            }
        }
    }
    
    
    /// Relationship data to include in the response.
    public enum Relationship: String, CaseIterable, Parameter {
        case betaAppLocalizations, betaAppReviewDetail, betaGroups, betaLicenseAgreement, builds, preReleaseVersions
        
        static var key: String = "include"
        var value: Any { return self.rawValue }
    }
    
    
    /// Attributes by which to sort.
    public enum SortableField: String, RawRepresentable {
        case bundleId
        case name
        case sku
    }
    
    
    /// Number of included related resources to return.
    public enum Limit: NestableParameter {
        
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
                return (nil, value)
            case .preReleaseVersions(let value):
                return ("preReleaseVersions", value)
            case .builds(let value):
                return ("builds", value)
            case .betaGroups(let value):
                return ("betaGroups", value)
            case .betaAppLocalizations(let value):
                return ("betaAppLocalizations", value)
            }
        }
    }
}
