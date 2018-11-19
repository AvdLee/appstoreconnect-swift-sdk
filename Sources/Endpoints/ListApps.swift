//
//  ListApps.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 16/11/2018.
//

import Foundation

public struct ListApps: Endpoint {
    
    public typealias Response = AppsResponse
    public var path: String = "apps"
    public var parameters: [String: Any]? = nil
    
    public init(
        select fields: [Field]? = nil,
        filters: [Filter]? = nil,
        include relationships: [Relationship]? = nil,
        sortBy: [Sorting<SortableField>]? = nil,
        limits: [Limit]? = nil)
    {
        var params = [String: Any]()
        if let fields = fields {
            for (key, value) in fields.map({ $0.pair }) {
                params[key] = value
            }
        }
        if let filters = filters {
            for (key, value) in filters.map({ $0.pair }) {
                params[key] = value
            }
        }
        if let relationships = relationships {
            params["include"] = relationships
                .map({ $0.rawValue })
                .joined(separator: ",")
        }
        if let sortBy = sortBy {
            params["sort"] = sortBy.map({
                switch $0 {
                case .default(let field):
                    return field.rawValue
                case .ascending(let field):
                    return "+\(field.rawValue)"
                case .descending(let field):
                    return "-\(field.rawValue)"
                }
            }).joined(separator: ",")
        }
        if let limits = limits {
            for (key, value) in limits.map({ $0.pair }) {
                params[key] = value
            }
        }
        parameters = params
    }
}

// MARK: - Fields
extension ListApps {
    public enum Field {
        case apps([Apps])
        case betaLicenseAgreements([BetaLicenseAgreements])
        case preReleaseVersions([PreReleaseVersions])
        case betaAppReviewDetails([BetaAppReviewDetails])
        case betaAppLocalizations([BetaAppLocalizations])
        case builds([Builds])
        case betaGroups([BetaGroups])

        var pair: (key: String, value: String) {
            switch self {
            case .apps(let value):
                return ("fields[apps]", value.map({ $0.rawValue }).joined(separator: ","))
            case .betaLicenseAgreements(let value):
                return ("fields[betaLicenseAgreements]", value.map({ $0.rawValue }).joined(separator: ","))
            case .preReleaseVersions(let value):
                return ("fields[preReleaseVersions]", value.map({ $0.rawValue }).joined(separator: ","))
            case .betaAppReviewDetails(let value):
                return ("fields[betaAppReviewDetails]", value.map({ $0.rawValue }).joined(separator: ","))
            case .betaAppLocalizations(let value):
                return ("fields[betaAppLocalizations]", value.map({ $0.rawValue }).joined(separator: ","))
            case .builds(let value):
                return ("fields[builds]", value.map({ $0.rawValue }).joined(separator: ","))
            case .betaGroups(let value):
                return ("fields[betaGroups]", value.map({ $0.rawValue }).joined(separator: ","))
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
}


// MARK: - Filters
extension ListApps {
    public enum Filter {
        case bundleId([String])
        case id([String])
        case name([String])
        case sku([String])
        
        var pair: (key: String, value: String) {
            switch self {
            case .bundleId(let value):
                return ("filter[bundleId]", value.joined(separator: ","))
            case .id(let value):
                return ("filter[id]", value.joined(separator: ","))
            case .name(let value):
                return ("filter[name]", value.joined(separator: ","))
            case .sku(let value):
                return ("filter[sku]", value.joined(separator: ","))
            }
        }
    }
}


// MARK: - Relationships
extension ListApps {
    public enum Relationship: String, CaseIterable {
        case betaAppLocalizations, betaAppReviewDetail, betaGroups, betaLicenseAgreement, builds, preReleaseVersions
    }
}


// MARK: - Sort
extension ListApps {
    public enum SortableField: String, SortableValue {
        case bundleId
        case name
        case sku
    }
}


// MARK: - Limits
extension ListApps {
    public enum Limit {
        case apps(Int)
        case preReleaseVersions(Int)
        case builds(Int)
        case betaGroups(Int)
        case betaAppLocalizations(Int)

        var pair: (key: String, value: Int) {
            switch self {
            case .apps(let value):
                return ("limit", value)
            case .preReleaseVersions(let value):
                return ("limit[preReleaseVersions]", value)
            case .builds(let value):
                return ("limit[builds]", value)
            case .betaGroups(let value):
                return ("limit[betaGroups]", value)
            case .betaAppLocalizations(let value):
                return ("limit[betaAppLocalizations]", value)
            }
        }
    }
}
