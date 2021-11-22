//
//  ListBetaTestersInBetaGroup.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == BetaTestersResponse {

    /// Get a list of beta testers contained in a specific beta group.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - limit: Number of resources to return.
    ///   - fields: Fields to return for included related types.
    ///   - next: The next URL to use as a base. See `PagedDocumentLinks`.
    public static func betaTesters(
        inBetaGroupWithId id: String,
        limit: Int? = nil,
        fields: [ListBetaTestersInBetaGroup.Field]? = nil,
        next: PagedDocumentLinks? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let limit = limit {
            parameters["limit"] = limit
        } else if let nextLimit = next?.nextLimit {
            parameters["limit"] = nextLimit
        }
        if let fields = fields { parameters.add(fields) }
        if let nextCursor = next?.nextCursor { parameters["cursor"] = nextCursor }
        return APIEndpoint(
            path: "betaGroups/\(id)/betaTesters",
            method: .get,
            parameters: parameters)
    }
}

public enum ListBetaTestersInBetaGroup {

    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case betaTesters([BetaTester])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .betaTesters(let value):
                return (BetaTester.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }
}

extension ListBetaTestersInBetaGroup.Field {

    public enum BetaTester: String, CaseIterable, NestableQueryParameter {
        case apps, betaGroups, builds, email, firstName, inviteType, lastName

        static var key: String = "betaTester"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
