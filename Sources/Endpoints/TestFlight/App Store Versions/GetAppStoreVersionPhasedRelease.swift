//
//  GetAppStoreVersionPhasedRelease.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by James Sherlock on 14/12/2020.
//

import Foundation

extension APIEndpoint where T == AppStoreVersionPhasedReleaseResponse {
    /// Get the app store phased release status for a specifi version.
    ///
    /// - Parameters:
    ///   - id: An opaque resource ID that uniquely identifies the resource.
    ///   - fields: Fields to return for included related types.
    public static func appStoreVersionPhasedRelease(
        ofVersionWithId id: String,
        fields: [GetAppStoreVersionPhasedRelease.Field]? = nil
    ) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }

        return APIEndpoint(
            path: "appStoreVersions/\(id)/appStoreVersionPhasedRelease",
            method: .get,
            parameters: parameters)
    }
}

public enum GetAppStoreVersionPhasedRelease {
    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        public enum Value: String, CaseIterable {
            case currentDayNumber
            case phasedReleaseState
            case startDate
            case totalPauseDuration
        }

        case appStoreVersionPhasedReleases([Value])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .appStoreVersionPhasedReleases(let values):
                return ("appStoreVersionPhasedReleases", values.map(\.rawValue).joinedByCommas())
            }
        }
    }
}
