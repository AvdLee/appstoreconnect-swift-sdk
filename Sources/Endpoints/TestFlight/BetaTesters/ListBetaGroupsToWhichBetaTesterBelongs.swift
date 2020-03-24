//
//  ListBetaGroupsToWhichBetaTesterBelongs.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//

extension APIEndpoint where Request == EmptyBody, Response == BetaGroupsResponse {

    /// Get a list of beta groups that contain a specific beta tester.
    ///
    /// - Parameters:
    ///   - id: An opaque resource ID that uniquely identifies the resource.
    ///   - limit: Number of resources to return.
    ///   - fields: Fields to return for included related types.
    ///   - next: The next URL to use as a base. See `PagedDocumentLinks`.
    public static func betaGroups(
        toWhichBelongBetaTesterWithId id: String,
        limit: Int? = nil,
        fields: [ListBetaGroupsToWhichBetaTesterBelongs.Field]? = nil,
        next: PagedDocumentLinks? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }
        if let fields = fields { parameters.add(fields) }
        if let nextCursor = next?.nextCursor { parameters["cursor"] = nextCursor }
        return APIEndpoint(
            path: "betaTesters/\(id)/betaGroups",
            method: .get,
            parameters: parameters)
    }
}

public enum ListBetaGroupsToWhichBetaTesterBelongs {

    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case betaGroups([BetaGroup])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .betaGroups(let value):
                return (BetaGroup.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }
}

extension ListBetaGroupsToWhichBetaTesterBelongs.Field {
    
    public enum BetaGroup: String, CaseIterable, NestableQueryParameter {
        case app, betaTesters, builds, createdDate, isInternalGroup, name, publicLink, publicLinkEnabled, publicLinkId, publicLinkLimit, publicLinkLimitEnabled

        static var key: String = "betaGroup"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
