//
//  ListBuilds.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//
    
import Alamofire

extension APIEndpoint where T == BuildsResponse {

    /// Find and list builds for all apps in App Store Connect.
    ///
    /// - Parameters:
    ///   - fields: Fields to return for included related types.
    ///   - filter: Attributes, relationships, and IDs by which to filter.
    ///   - include: Relationship data to include in the response.
    ///   - limit: Number of resources to return.
    ///   - sort: Attributes by which to sort.
    ///   - next: The next URL to use as a base. See `PagedDocumentLinks`.
    public static func builds(
        fields: [ListBuilds.Field]? = nil,
        filter: [ListBuilds.Filter]? = nil,
        include: [ListBuilds.Include]? = nil,
        limit: [ListBuilds.Limit]? = nil,
        sort: [ListBuilds.Sort]? = nil,
        next: PagedDocumentLinks? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let filter = filter { parameters.add(filter) }
        if let include = include { parameters.add(include) }
        if let limit = limit { parameters.add(limit) }
        if let sort = sort { parameters.add(sort) }
        if let nextCursor = next?.nextCursor { parameters["cursor"] = nextCursor }
        return APIEndpoint(
            path: "builds",
            method: .get,
            parameters: parameters)
    }
}

public struct ListBuilds {

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
    
    /// Attributes, relationships, and IDs by which to filter.
    public enum Filter: NestableQueryParameter {
        case app([String])
        case expired([String])
        case id([String])
        case preReleaseVersion([String])
        case processingState([ProcessingState])
        case version([String])
        case usesNonExemptEncryption([String])
        case preReleaseVersionVersion([String])
        case betaGroups([String])
        case betaAppReviewSubmissionBetaReviewState([String])

        static var key: String = "filter"
        var pair: Pair {
            switch self {
            case .app(let value):
                return ("app", value.joinedByCommas())
            case .expired(let value):
                return ("expired", value.joinedByCommas())
            case .id(let value):
                return ("id", value.joinedByCommas())
            case .preReleaseVersion(let value):
                return ("prereleaseversion", value.joinedByCommas())
            case .processingState(let value):
                return (ProcessingState.key, value.map({ $0.pair.value }).joinedByCommas())
            case .version(let value):
                return ("version", value.joinedByCommas())
            case .usesNonExemptEncryption(let value):
                return ("usesnonexemptencryption", value.joinedByCommas())
            case .preReleaseVersionVersion(let value):
                return ("prereleaseversion.Version", value.joinedByCommas())
            case .betaGroups(let value):
                return ("betagroup", value.joinedByCommas())
            case .betaAppReviewSubmissionBetaReviewState(let value):
                return ("betaappreviewsubmission.betareviewstate", value.joinedByCommas())
            }
        }
    }
    
    /// Relationship data to include in the response.
    public enum Include: String, CaseIterable, NestableQueryParameter {
        case app, appEncryptionDeclaration, betaAppReviewSubmission, betaBuildLocalizations, buildBetaDetail, individualTesters, preReleaseVersion

        static var key: String = "include"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    /// Number of resources to return.
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
    
    /// Attributes by which to sort.
    public enum Sort: String, CaseIterable, NestableQueryParameter {
        case preReleaseVersionAscending = "+preReleaseVersion"
        case preReleaseVersionDescending = "-preReleaseVersion"
        case uploadedDateAscending = "+uploadedDate"
        case uploadedDateDescending = "-uploadedDate"
        case versionAscending = "+version"
        case versionDescending = "-version"

        static var key: String = "sort"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}

// MARK: - Field
extension ListBuilds.Field {
    
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

// MARK: - Filter
extension ListBuilds.Filter {
    
    public enum ProcessingState: String, CaseIterable, NestableQueryParameter {
        case PROCESSING, FAILED, INVALID, VALID

        static var key: String = "processingState"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
