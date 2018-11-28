//
//  ListAppsForBetaTester.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint where T == AppsResponse {

    /// Get a list of apps that a beta tester can test.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - limit: Number of resources to return.
    ///   - fields: Fields to return for included related types.
    public static func apps(
        forBetaTesterWithId id: String,
        limit: Int? = nil,
        fields: [ListAppsForBetaTester.Field]? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }
        if let fields = fields { parameters.add(fields) }
        return APIEndpoint(
            path: "betaTesters/\(id)/apps",
            method: .get,
            parameters: parameters)
    }
}

public struct ListAppsForBetaTester {
    
    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case apps([App])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .apps(let value):
                return (App.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }
}

extension ListAppsForBetaTester.Field {
    
    public enum App: String, CaseIterable, NestableQueryParameter {
        case betaAppLocalizations, betaAppReviewDetail, betaGroups, betaLicenseAgreement, betaTesters, builds, bundleId, name, preReleaseVersions, primaryLocale, sku

        static var key: String = "app"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
