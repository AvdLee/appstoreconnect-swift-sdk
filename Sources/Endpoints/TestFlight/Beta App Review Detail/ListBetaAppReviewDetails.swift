//
//  ListBetaAppReviewDetails.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == BetaAppReviewDetailsResponse {

    /// Find and list beta app review details for all apps.
    ///
    /// - Parameters:
    ///   - fields: Fields to return for included related types.
    ///   - filter: Attributes, relationships, and IDs by which to filter.
    ///   - include: Relationship data to include in the response.
    ///   - limit: Number of resources to return.
    ///   - next: The next URL to use as a base. See `PagedDocumentLinks`.
    public static func betaAppReviewDetails(
        fields: [ListBetaAppReviewDetails.Field]? = nil,
        filter: [ListBetaAppReviewDetails.Filter]? = nil,
        include: [ListBetaAppReviewDetails.Include]? = nil,
        limit: Int? = nil,
        next: PagedDocumentLinks? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let filter = filter { parameters.add(filter) }
        if let include = include { parameters.add(include) }
        if let limit = limit { parameters["limit"] = limit }
        if let nextCursor = next?.nextCursor { parameters["cursor"] = nextCursor }
        return APIEndpoint(path: "betaAppReviewDetails", method: .get, parameters: parameters)
    }
}

public struct ListBetaAppReviewDetails {

    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case apps([App])
        case betaAppReviewDetails([BetaAppReviewDetail])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .apps(let value):
                return (App.key, value.map({ $0.pair.value }).joinedByCommas())
            case .betaAppReviewDetails(let value):
                return (BetaAppReviewDetail.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }
    
    /// Attributes, relationships, and IDs by which to filter.
    public enum Filter: NestableQueryParameter {
        case app([String])

        static var key: String = "filter"
        var pair: Pair {
            switch self {
            case .app(let value):
                return ("app", value.joinedByCommas())
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

extension ListBetaAppReviewDetails.Field {
    
    public enum App: String, CaseIterable, NestableQueryParameter {
        case betaAppLocalizations, betaAppReviewDetail, betaGroups, betaLicenseAgreement, betaTesters, builds, bundleId, name, preReleaseVersions, primaryLocale, sku

        static var key: String = "app"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum BetaAppReviewDetail: String, CaseIterable, NestableQueryParameter {
        case app, contactEmail, contactFirstName, contactLastName, contactPhone, demoAccountName, demoAccountPassword, demoAccountRequired, notes

        static var key: String = "betaAppReviewDetail"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
