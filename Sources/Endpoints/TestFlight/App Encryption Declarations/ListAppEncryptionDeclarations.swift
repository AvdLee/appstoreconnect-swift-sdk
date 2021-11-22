//
//  ListAppEncryptionDeclarations.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == AppEncryptionDeclarationsResponse {

    /// Find and list all available app encryption declarations.
    ///
    /// - Parameters:
    ///   - fields: Fields to return for included related types.
    ///   - filter: Attributes, relationships, and IDs by which to filter.
    ///   - include: Relationship data to include in the response.
    ///   - limit: Number of resources to return.
    ///   - next: The next URL to use as a base. See `PagedDocumentLinks`.
    public static func appEncryptionDeclarations(
        fields: [ListAppEncryptionDeclarations.Field]? = nil,
        filter: [ListAppEncryptionDeclarations.Filter]? = nil,
        include: [ListAppEncryptionDeclarations.Include]? = nil,
        limit: Int? = nil,
        next: PagedDocumentLinks? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let filter = filter { parameters.add(filter) }
        if let include = include { parameters.add(include) }
        if let limit = limit {
            parameters["limit"] = limit
        } else if let nextLimit = next?.nextLimit {
            parameters["limit"] = nextLimit
        }
        if let nextCursor = next?.nextCursor { parameters["cursor"] = nextCursor }
        return APIEndpoint(
            path: "appEncryptionDeclarations",
            method: .get,
            parameters: parameters)
    }
}

public enum ListAppEncryptionDeclarations {

    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case appEncryptionDeclarations([AppEncryptionDeclaration])
        case apps([App])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .appEncryptionDeclarations(let value):
                return (AppEncryptionDeclaration.key, value.map({ $0.pair.value }).joinedByCommas())
            case .apps(let value):
                return (App.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }

    /// Attributes, relationships, and IDs by which to filter.
    public enum Filter: NestableQueryParameter {
        case app([String]), builds([String]), platform([String])

        static var key: String = "filter"
        var pair: Pair {
            switch self {
            case .app(let value):
                return ("app", value.joinedByCommas())
            case .builds(let value):
                return ("builds", value.joinedByCommas())
            case .platform(let value):
                return ("platform", value.joinedByCommas())
            }
        }
    }

    /// Relationship data to include in the response.
    public enum Include: String, CaseIterable, NestableQueryParameter {
        case app

        static var key: String = "include"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}

extension ListAppEncryptionDeclarations.Field {

    public enum AppEncryptionDeclaration: String, CaseIterable, NestableQueryParameter {
        case app, appEncryptionDeclarationState, availableOnFrenchStore, builds, codeValue, containsProprietaryCryptography, containsThirdPartyCryptography, documentName, documentType, documentUrl, exempt, platform, uploadedDate, usesEncryption

        static var key: String = "appEncryptionDeclaration"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    public enum App: String, CaseIterable, NestableQueryParameter {
        case betaAppLocalizations, betaAppReviewDetail, betaGroups, betaLicenseAgreement, betaTesters, builds, bundleId, name, preReleaseVersions, primaryLocale, sku

        static var key: String = "app"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
