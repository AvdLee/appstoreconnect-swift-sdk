//
//  ListBetaAppReviewSubmissions.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == BetaAppReviewSubmissionsResponse {

    /// Find and list beta app review submissions for all builds.
    ///
    /// - Parameters:
    ///   - fields: Fields to return for included related types.
    ///   - filter: Attributes, relationships, and IDs by which to filter.
    ///   - include: Relationship data to include in the response.
    ///   - limit: Number of resources to return.
    ///   - next: The next URL to use as a base. See `PagedDocumentLinks`.
    public static func betaAppReviewSubmissions(
        fields: [ListBetaAppReviewSubmissions.Field]? = nil,
        filter: [ListBetaAppReviewSubmissions.Filter]? = nil,
        include: [ListBetaAppReviewSubmissions.Include]? = nil,
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
        return APIEndpoint(path: "betaAppReviewSubmissions", method: .get, parameters: parameters)
    }
}

public enum ListBetaAppReviewSubmissions {

    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case betaAppReviewSubmissions([BetaAppReviewSubmission])
        case builds([Build])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .betaAppReviewSubmissions(let value):
                return (BetaAppReviewSubmission.key, value.map({ $0.pair.value }).joinedByCommas())
            case .builds(let value):
                return (Build.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }

    /// Attributes, relationships, and IDs by which to filter.
    public enum Filter: NestableQueryParameter {
        case betaReviewState([String]), build([String])

        static var key: String = "filter"
        var pair: Pair {
            switch self {
            case .betaReviewState(let value):
                return ("betaReviewState", value.joinedByCommas())
            case .build(let value):
                return ("build", value.joinedByCommas())
            }
        }
    }

    /// Relationship data to include in the response.
    public enum Include: String, CaseIterable, NestableQueryParameter {
        case build

        static var key: String = "include"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}

extension ListBetaAppReviewSubmissions.Field {

    public enum BetaAppReviewSubmission: String, CaseIterable, NestableQueryParameter {
        case betaReviewState, build

        static var key: String = "betaAppReviewSubmission"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    public enum Build: String, CaseIterable, NestableQueryParameter {
        case app, appEncryptionDeclaration, betaAppReviewSubmission, betaBuildLocalizations, betaGroups, buildBetaDetail, expirationDate, expired, iconAssetToken, individualTesters, minOsVersion, preReleaseVersion, processingState, uploadedDate, usesNonExemptEncryption, version

        static var key: String = "build"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
