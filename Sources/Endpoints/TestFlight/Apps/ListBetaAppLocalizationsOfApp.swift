//
//  ListBetaAppLocalizationsOfApp.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint where T == BetaAppLocalizationsResponse {

    /// Get a list of localized beta test information for a specific app.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - fields: Fields to return for included related types.
    ///   - limit: Number of resources to return.
    public static func betaAppLocalizations(
        ofAppWithId id: String,
        fields: [ListBetaAppLocalizationsForApp.Field]? = nil,
        limit: Int? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let limit = limit { parameters["limit"] = limit }
        return APIEndpoint(
            path: "apps/\(id)/betaAppLocalizations",
            method: .get,
            parameters: parameters)
    }
}

public struct ListBetaAppLocalizationsForApp {

    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case betaAppLocalizations([BetaAppLocalization])
        
        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .betaAppLocalizations(let value):
                return (BetaAppLocalization.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }
}

extension ListBetaAppLocalizationsForApp.Field {

    public enum BetaAppLocalization: String, CaseIterable, NestableQueryParameter {
        case app, description, feedbackEmail, locale, marketingUrl, privacyPolicyUrl, tvOsPrivacyPolicy

        static var key: String = "betaAppLocalization"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
