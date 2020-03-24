//
//  ListBetaBuildLocalizationsOfBuild.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where Request == EmptyBody, Response == BetaBuildLocalizationsResponse {

    /// Get a list of localized beta test information for a specific build.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - fields: Fields to return for included related types.
    ///   - limit: Number of resources to return.
    ///   - next: The next URL to use as a base. See `PagedDocumentLinks`.
    public static func betaBuildLocalizations(
        ofBuildWithId id: String,
        fields: [ListBetaBuildLocalizationsOfBuild.Field]? = nil,
        limit: Int? = nil,
        next: PagedDocumentLinks? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let limit = limit { parameters["limit"] = limit }
        if let nextCursor = next?.nextCursor { parameters["cursor"] = nextCursor }
        return APIEndpoint(
            path: "builds/\(id)/betaBuildLocalizations",
            method: .get,
            parameters: parameters)
    }
}

public enum ListBetaBuildLocalizationsOfBuild {

    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case betaBuildLocalizations([BetaBuildLocalization])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .betaBuildLocalizations(let value):
                return (BetaBuildLocalization.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }
}

extension ListBetaBuildLocalizationsOfBuild.Field {
    
    public enum BetaBuildLocalization: String, CaseIterable, NestableQueryParameter {
        case build, locale, whatsNew

        static var key: String = "betaBuildLocalization"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
