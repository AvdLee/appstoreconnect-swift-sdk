//
//  ListBuilds.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

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
        if let limit = limit {
            parameters.add(limit)
        } else if let nextLimit = next?.nextLimit {
            parameters["limit"] = nextLimit
        }
        if let sort = sort { parameters.add(sort) }
        if let nextCursor = next?.nextCursor { parameters["cursor"] = nextCursor }
        return APIEndpoint(
            path: "builds",
            method: .get,
            parameters: parameters)
    }
}

public enum ListBuilds {

    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case appEncryptionDeclarations([AppEncryptionDeclaration])
        case appStoreVersions([AppStoreVersion])
        case apps([App])
        case betaAppReviewSubmissions([BetaAppReviewSubmission])
        case betaBuildLocalizations([BetaBuildLocalization])
        case betaTesters([BetaTester])
        case buildBetaDetails([BuildBetaDetail])
        case buildIcons([BuildIcon])
        case builds([Build])
        case diagnosticSignatures([DiagnosticSignature])
        case perfPowerMetrics([PerfPowerMetric])
        case preReleaseVersions([PreReleaseVersion])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .appEncryptionDeclarations(let value):
                return (AppEncryptionDeclaration.key, value.map({ $0.pair.value }).joinedByCommas())
            case .appStoreVersions(let value):
                return (AppStoreVersion.key, value.map({ $0.pair.value }).joinedByCommas())
            case .apps(let value):
                return (App.key, value.map({ $0.pair.value }).joinedByCommas())
            case .betaAppReviewSubmissions(let value):
                return (BetaAppReviewSubmission.key, value.map({ $0.pair.value }).joinedByCommas())
            case .betaBuildLocalizations(let value):
                return (BetaBuildLocalization.key, value.map({ $0.pair.value }).joinedByCommas())
            case .betaTesters(let value):
                return (BetaTester.key, value.map({ $0.pair.value }).joinedByCommas())
            case .buildBetaDetails(let value):
                return (BuildBetaDetail.key, value.map({ $0.pair.value }).joinedByCommas())
            case .buildIcons(let value):
                return (BuildIcon.key, value.map({ $0.pair.value }).joinedByCommas())
            case .builds(let value):
                return (Build.key, value.map({ $0.pair.value }).joinedByCommas())
            case .diagnosticSignatures(let value):
                return (DiagnosticSignature.key, value.map({ $0.pair.value }).joinedByCommas())
            case .perfPowerMetrics(let value):
                return (PerfPowerMetric.key, value.map({ $0.pair.value }).joinedByCommas())
            case .preReleaseVersions(let value):
                return (PreReleaseVersion.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }
    
    /// Attributes, relationships, and IDs by which to filter.
    public enum Filter: NestableQueryParameter {
        case app([String])
        case appStoreVersion([String])
        case betaAppReviewSubmissionBetaReviewState([String])
        case betaGroups([String])
        case expired([String])
        case id([String])
        case preReleaseVersion([String])
        case preReleaseVersionVersion([String])
        case preReleaseVersionPlatform([PreReleaseVersionPlatform])
        case processingState([ProcessingState])
        case usesNonExemptEncryption([String])
        case version([String])

        static var key: String = "filter"
        var pair: Pair {
            switch self {
            case .app(let value):
                return ("app", value.joinedByCommas())
            case .appStoreVersion(let value):
                return ("appStoreVersion", value.joinedByCommas())
            case .betaAppReviewSubmissionBetaReviewState(let value):
                return ("betaAppReviewSubmission.betaReviewState", value.joinedByCommas())
            case .betaGroups(let value):
                return ("betagroup", value.joinedByCommas())
            case .expired(let value):
                return ("expired", value.joinedByCommas())
            case .id(let value):
                return ("id", value.joinedByCommas())
            case .preReleaseVersion(let value):
                return ("preReleaseVersion", value.joinedByCommas())
            case .preReleaseVersionPlatform(let value):
                return (PreReleaseVersionPlatform.key, value.map({ $0.pair.value }).joinedByCommas())
            case .preReleaseVersionVersion(let value):
                return ("preReleaseVersion.version", value.joinedByCommas())
            case .processingState(let value):
                return (ProcessingState.key, value.map({ $0.pair.value }).joinedByCommas())
            case .usesNonExemptEncryption(let value):
                return ("usesNonExemptEncryption", value.joinedByCommas())
            case .version(let value):
                return ("version", value.joinedByCommas())
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
            case .betaBuildLocalizations(let value):
                return ("betaBuildLocalizations", "\(value)")
            case .individualTesters(let value):
                return ("individualTesters", "\(value)")
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
    public enum App: String, CaseIterable, NestableQueryParameter {
        case appInfos, appStoreVersions, availableInNewTerritories, availableTerritories, betaAppLocalizations, betaAppReviewDetail, betaGroups, betaLicenseAgreement, betaTesters, builds, bundleId, contentRightsDeclaration, endUserLicenseAgreement, gameCenterEnabledVersions, inAppPurchases, isOrEverWasMadeForKids, name, perfPowerMetrics, preOrder, preReleaseVersions, prices, primaryLocale, sku

        static var key: String = "apps"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    public enum AppEncryptionDeclaration: String, CaseIterable, NestableQueryParameter {
        case app, appEncryptionDeclarationState, availableOnFrenchStore, builds, codeValue, containsProprietaryCryptography, containsThirdPartyCryptography, documentName, documentType, documentUrl, exempt, platform, uploadedDate, usesEncryption

        static var key: String = "appEncryptionDeclarations"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    public enum AppStoreVersion: String, CaseIterable, NestableQueryParameter {
        case ageRatingDeclaration, app, appStoreReviewDetail, appStoreState, appStoreVersionLocalizations, appStoreVersionPhasedRelease, appStoreVersionSubmission, build, copyright, createdDate, downloadable, earliestReleaseDate, idfaDeclaration, platform, releaseType, routingAppCoverage, usesIdfa, versionString

        static var key: String = "appStoreVersions"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    public enum BetaAppReviewSubmission: String, CaseIterable, NestableQueryParameter {
        case betaReviewState, build

        static var key: String = "betaAppReviewSubmissions"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    public enum BetaBuildLocalization: String, CaseIterable, NestableQueryParameter {
        case build, locale, whatsNew

        static var key: String = "betaBuildLocalizations"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    public enum BetaTester: String, CaseIterable, NestableQueryParameter {
        case apps, betaGroups, builds, email, firstName, inviteType, lastName

        static var key: String = "betaTesters"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum Build: String, CaseIterable, NestableQueryParameter {
        case app, appEncryptionDeclaration, appStoreVersion, betaAppReviewSubmission, betaBuildLocalizations, betaGroups, buildBetaDetail, diagnosticSignatures, expirationDate, expired, iconAssetToken, icons, individualTesters, minOsVersion, perfPowerMetrics, preReleaseVersion, processingState, uploadedDate, usesNonExemptEncryption, version

        static var key: String = "builds"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    public enum BuildBetaDetail: String, CaseIterable, NestableQueryParameter {
        case autoNotifyEnabled, build, externalBuildState, internalBuildState

        static var key: String = "buildBetaDetails"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    public enum BuildIcon: String, CaseIterable, NestableQueryParameter {
        case iconAsset, iconType

        static var key: String = "buildIcons"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    public enum DiagnosticSignature: String, CaseIterable, NestableQueryParameter {
        case diagnosticType, logs, signature, weight

        static var key: String = "diagnosticSignatures"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    public enum PerfPowerMetric: String, CaseIterable, NestableQueryParameter {
        case deviceType, metricType, platform

        static var key: String = "perfPowerMetrics"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    public enum PreReleaseVersion: String, CaseIterable, NestableQueryParameter {
        case app, builds, platform, version

        static var key: String = "preReleaseVersions"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}

// MARK: - Filter
extension ListBuilds.Filter {
    public enum PreReleaseVersionPlatform: String, CaseIterable, NestableQueryParameter {
        case IOS, MAC_OS, TV_OS

        static var key: String = "preReleaseVersion.platform"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    public enum ProcessingState: String, CaseIterable, NestableQueryParameter {
        case PROCESSING, FAILED, INVALID, VALID

        static var key: String = "processingState"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
