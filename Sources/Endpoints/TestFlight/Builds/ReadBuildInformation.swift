//
//  ReadBuildInformation.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//
    
import Alamofire

extension APIEndpoint where T == BuildResponse {

    /// Get information about a specific build.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - fields: Fields to return for included related types.
    ///   - include: Relationship data to include in the response.
    ///   - limit: Number of included related resources to return.
    public static func build(
        withId id: String,
        fields: [ReadBuildInformation.Field]? = nil,
        include: [ReadBuildInformation.Include]? = nil,
        limit: [ReadBuildInformation.Limit]? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let include = include { parameters.add(include) }
        if let limit = limit { parameters.add(limit) }
        return APIEndpoint(path: "builds/\(id)", method: .get, parameters: parameters)
    }
}

public struct ReadBuildInformation {

    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case appEncryptionDeclarations([AppEncryptionDeclaration])
        case apps([App])
        case betaTesters([BetaTester])
        case builds([Build])
        case preReleaseVersions([PreReleaseVersion])
        case buildBetaDetails([BuildBetaDetail])
        case betaAppReviewSubmissions([BetaAppReviewSubmission])
        case betaBuildLocalizations([BetaBuildLocalization])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .appEncryptionDeclarations(let value):
                return (AppEncryptionDeclaration.key, value.map({ $0.pair.value }).joinedByCommas())
            case .apps(let value):
                return (App.key, value.map({ $0.pair.value }).joinedByCommas())
            case .betaTesters(let value):
                return (BetaTester.key, value.map({ $0.pair.value }).joinedByCommas())
            case .builds(let value):
                return (Build.key, value.map({ $0.pair.value }).joinedByCommas())
            case .preReleaseVersions(let value):
                return (PreReleaseVersion.key, value.map({ $0.pair.value }).joinedByCommas())
            case .buildBetaDetails(let value):
                return (BuildBetaDetail.key, value.map({ $0.pair.value }).joinedByCommas())
            case .betaAppReviewSubmissions(let value):
                return (BetaAppReviewSubmission.key, value.map({ $0.pair.value }).joinedByCommas())
            case .betaBuildLocalizations(let value):
                return (BetaBuildLocalization.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }
    
    /// Relationship data to include in the response.
    public enum Include: String, CaseIterable, NestableQueryParameter {
        case app, appEncryptionDeclaration, betaAppReviewSubmission, betaBuildLocalizations, buildBetaDetail, individualTesters, preReleaseVersion

        static var key: String = "include"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    /// Number of included related resources to return.
    public enum Limit: NestableQueryParameter {
        case individualTesters(Int), betaBuildLocalizations(Int)

        static var key: String = "limit"
        var pair: Pair {
            switch self {
            case .individualTesters(let value):
                return ("individualTesters", "\(value)")
            case .betaBuildLocalizations(let value):
                return ("betaBuildLocalizations", "\(value)")
            }
        }
    }
}

extension ReadBuildInformation.Field {
    
    public enum AppEncryptionDeclaration: String, CaseIterable, NestableQueryParameter {
        case app, appEncryptionDeclarationState, availableOnFrenchStore, builds, codeValue, containsProprietaryCryptography, containsThirdPartyCryptography, documentName, documentType, documentUrl, exempt, platform, uploadedDate, usesEncryption

        static var key: String = "AppEncryptionDeclaration"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum App: String, CaseIterable, NestableQueryParameter {
        case betaAppLocalizations, betaAppReviewDetail, betaGroups, betaLicenseAgreement, betaTesters, builds, bundleId, name, preReleaseVersions, primaryLocale, sku

        static var key: String = "App"
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
    
    public enum PreReleaseVersion: String, CaseIterable, NestableQueryParameter {
        case app, builds, platform, version

        static var key: String = "preReleaseVersion"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum BuildBetaDetail: String, CaseIterable, NestableQueryParameter {
        case autoNotifyEnabled, build, externalBuildState, internalBuildState

        static var key: String = "buildBetaDetail"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum BetaAppReviewSubmission: String, CaseIterable, NestableQueryParameter {
        case betaReviewState, build

        static var key: String = "betaAppReviewSubmission"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum BetaBuildLocalization: String, CaseIterable, NestableQueryParameter {
        case build, locale, whatsNew

        static var key: String = "betaBuildLocalization"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
