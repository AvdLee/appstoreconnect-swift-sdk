//
//  ListBetaGroupsToWhichBetaTesterBelongs.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint {

    /// Get a list of beta groups that contain a specific beta tester.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - limit: Number of resources to return.
    ///   - fields: Fields to return for included related types.
    public static func listBetaGroupsToWhichBetaTesterBelongs(
        withId id: String,
        limit: Int? = nil,
        fields: [ListBetaGroupsToWhichBetaTesterBelongs.Field]? = nil) -> APIEndpoint<BetaGroupsResponse> {
        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }
        if let fields = fields { parameters.add(fields) }
        return APIEndpoint<BetaGroupsResponse>(
            path: "betaTesters/\(id)/betaGroups",
            method: .get,
            parameters: parameters)
    }
}

public struct ListBetaGroupsToWhichBetaTesterBelongs {

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
