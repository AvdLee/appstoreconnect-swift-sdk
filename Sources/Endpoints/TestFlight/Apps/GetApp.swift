//
//  ReadAppInformation.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 20/11/2018.
//

import Alamofire

extension APIEndpoint {
    
    /// Get information about a specific app.
    ///
    /// - Parameters:
    ///   - id: An opaque resource ID that uniquely identifies the resource.
    ///   - fields: Fields to return for included related types.
    ///   - relationships: Relationship data to include in the response.
    ///   - limits: Number of included related resources to return.
    public static func app(
        withId id: String,
        select fields: [ReadAppInformation.Field]? = nil,
        include relationships: [ReadAppInformation.Relationship]? = nil,
        limits: [ReadAppInformation.Limit]? = nil) -> APIEndpoint<AppResponse> {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let relationships = relationships { parameters.add(relationships) }
        if let limits = limits { parameters.add(limits) }
        return APIEndpoint<AppResponse>(
            path: "apps/\(id)",
            method: .get,
            parameters: parameters)
    }
}

public struct ReadAppInformation {
    
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
    
    /// Relationship data to include in the response.
    public enum Relationship: String, CaseIterable, NestableQueryParameter {
        case betaAppLocalizations, betaAppReviewDetail, betaGroups, betaLicenseAgreement, builds, preReleaseVersions
        
        static var key: String = "include"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    /// Number of included related resources to return.
    public enum Limit: NestableQueryParameter {
        case preReleaseVersions(Int)
        case builds(Int)
        case betaGroups(Int)
        case betaAppLocalizations(Int)
        
        static var key: String = "limit"
        var pair: Pair {
            switch self {
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

extension ReadAppInformation.Field {
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
