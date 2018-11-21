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
    public static func readAppInformation(
        for id: String,
        select fields: [ReadAppInformation.Field]? = nil,
        include relationships: [ReadAppInformation.Relationship]? = nil,
        limits: [ReadAppInformation.Limit]? = nil) -> APIEndpoint<AppResponse>
    {
        var parameters = [String: Any]()
        if let fields = fields { parameters.merge(with: fields) }
        if let relationships = relationships { parameters.merge(with: relationships) }
        if let limits = limits { parameters.merge(with: limits) }
        return APIEndpoint<AppResponse>(path: "apps/\(id)", method: .get, parameters: parameters)
    }
}

public struct ReadAppInformation {
    
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
    
    
    /// Relationship data to include in the response.
    public enum Relationship: String, CaseIterable, Parameter {
        case betaAppLocalizations, betaAppReviewDetail, betaGroups, betaLicenseAgreement, builds, preReleaseVersions
        
        static var key: String = "include"
        var value: Any { return rawValue }
    }
    
    
    /// Number of included related resources to return.
    public enum Limit: NestableParameter {
        case preReleaseVersions(Int)
        case builds(Int)
        case betaGroups(Int)
        case betaAppLocalizations(Int)
        
        static var key: String = "limit"
        var pair: Pair {
            switch self {
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
