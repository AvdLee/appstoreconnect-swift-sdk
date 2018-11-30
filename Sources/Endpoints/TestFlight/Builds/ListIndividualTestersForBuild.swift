//
//  ListIndividualTestersForBuild.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//
    
import Alamofire

extension APIEndpoint where T == BetaTestersResponse {

    /// Get a list of beta testers individually assigned to a build.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - limit: Number of resources to return
    ///   - fields: Fields to return for included related types.
    public static func individualTesters(
        forBuildWithId id: String,
        limit: Int? = nil,
        fields: [ListIndividualTestersForBuild.Field]? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }
        if let fields = fields { parameters.add(fields) }
        return APIEndpoint(path: "builds/\(id)/individualTesters", method: .get, parameters: parameters)
    }
}

public struct ListIndividualTestersForBuild {
    
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

extension ListIndividualTestersForBuild.Field {
    
    public enum BetaTester: String, CaseIterable, NestableQueryParameter {
        case apps, betaGroups, builds, email, firstName, inviteType, lastName

        static var key: String = "betaTester"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
