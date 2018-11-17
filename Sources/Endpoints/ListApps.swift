//
//  ListApps.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 16/11/2018.
//

import Alamofire

final public class ListApps: Endpoint<AppsResponse> {
    
    public init(
        fields: [Field]? = nil,
        filters: [Filter]? = nil,
        relationships: [Relationship]? = nil,
        sortBy: [Sorting<SortableField>]? = nil,
        limits: [Limit]? = nil)
    {
        super.init()
        _ = fields.map { select(fields: $0) }
        _ = filters.map { filter(by: $0) }
        _ = relationships.map { include(relationships: $0) }
        _ = sortBy.map { sort(by: $0) }
        _ = limits.map { limit(by: $0) }
    }
    
    override func path() -> String {
        return "apps"
    }
}

// MARK: - Fields
extension ListApps {
    
    @discardableResult
    public func select(fields: Field...) -> ListApps {
        return select(fields: fields)
    }
    
    @discardableResult
    public func select(fields: [Field]) -> ListApps {
        for (key, value) in fields.map({ $0.pair }) {
            parameters[key] = value
        }
        return self
    }
    
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


// MARK: - Filters
extension ListApps {
    
    @discardableResult
    public func filter(by filters: Filter...) -> ListApps {
        return filter(by: filters)
    }
    
    @discardableResult
    public func filter(by filters: [Filter]) -> ListApps {
        for filter in filters {
            switch filter {
            case .bundleId(let value):
                parameters["filter[bundleId]"] = value.joined(separator: ",")
            case .id(let value):
                parameters["filter[id]"] = value.joined(separator: ",")
            case .name(let value):
                parameters["filter[name]"] = value.joined(separator: ",")
            case .sku(let value):
                parameters["filter[sku]"] = value.joined(separator: ",")
            }
        }
        return self
    }

    public enum Filter {
        case bundleId([String])
        case id([String])
        case name([String])
        case sku([String])
    }
}


// MARK: - Sort
extension ListApps {
    
    @discardableResult
    public func sort(by sortings: Sorting<SortableField>...) -> ListApps {
        return sort(by: sortings)
    }
    
    @discardableResult
    public func sort(by sortings: [Sorting<SortableField>]) -> ListApps {
        parameters["sort"] = sortings.map({
            switch $0 {
            case .default(let field):
                return field.rawValue
            case .ascending(let field):
                return "+\(field.rawValue)"
            case .descending(let field):
                return "-\(field.rawValue)"
            }
        }).joined(separator: ",")
        return self
    }

    public enum SortableField: String, SortableValue {
        case bundleId
        case name
        case sku
    }
}


// MARK: - Limits
extension ListApps {
    
    @discardableResult
    public func limit(by limits: [Limit]) -> ListApps {
        for (key, value) in limits.map({ $0.pair }) {
            parameters[key] = value
        }
        return self
    }

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

// MARK: - Relationships
extension ListApps {
    
    @discardableResult
    public func include(relationships: Relationship...) -> ListApps {
        return include(relationships: relationships)
    }
    
    @discardableResult
    public func include(relationships: [Relationship]) -> ListApps {
        parameters["include"] = relationships
            .map({ $0.rawValue })
            .joined(separator: ",")
        
        return self
    }

    public enum Relationship: String, CaseIterable {
        case betaAppLocalizations, betaAppReviewDetail, betaGroups, betaLicenseAgreement, builds, preReleaseVersions
    }
}
