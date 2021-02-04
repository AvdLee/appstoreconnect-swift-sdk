//
//  ListAppStoreVersionLocalizations.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Kirill Budevich on 1/27/21.
//

import Foundation

extension APIEndpoint where T == AppStoreVersionLocalizationsResponse {
    /// Get a list of localized, version-level information about an app, for all locales.
    ///
    /// - Parameters:
    ///   - id: An opaque resource ID that uniquely identifies the resource.
    ///   - fields: Fields to return for included related types.
    ///   - limit: Number of resources to return.
    public static func appStoreVersionLocalizations(
        ofAppStoreVersionWithId id: String,
        fields: [ListLocalizationsOfAppStoreVersion.Field]? = nil,
        limit: Int? = nil
    ) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let limit = limit { parameters["limit"] = limit }
        return APIEndpoint(
            path: "appStoreVersions/\(id)/appStoreVersionLocalizations",
            method: .get,
            parameters: parameters)
    }
}

public enum ListLocalizationsOfAppStoreVersion {
    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case appStoreVersionLocalizations([AppStoreVersionLocalizations])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .appStoreVersionLocalizations(let value):
                return (AppStoreVersionLocalizations.key, value.map { $0.pair.value }.joinedByCommas())
            }
        }
    }
}

extension ListLocalizationsOfAppStoreVersion.Field {
    public enum AppStoreVersionLocalizations: String, CaseIterable, NestableQueryParameter {
        case appPreviewSets, appScreenshotSets, appStoreVersion, description, keywords, locale, marketingUrl, promotionalText, supportUrl, whatsNew

        static var key: String = "appStoreVersionLocalizations"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
