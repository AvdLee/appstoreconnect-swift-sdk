//
//  ListAppsVisibleToInvitedUser.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == AppsResponse {

    /// Get a list of apps that will be visible to a user with a pending invitation.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    
    ///   - limit: Number of resources to return.
    ///   - fields: Fields to return for included related types.
    ///   - next: The next URL to use as a base. See `PagedDocumentLinks`.
    public static func apps(
        visibleToInvitedUserWithId id: String,
        fields: [ListAppsVisibleToInvitedUser.Field]? = nil,
        limit: Int? = nil,
        next: PagedDocumentLinks? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }
        if let fields = fields { parameters.add(fields) }
        if let nextCursor = next?.nextCursor { parameters["cursor"] = nextCursor }
        return APIEndpoint(path: "userInvitations/\(id)/visibleApps", method: .get, parameters: parameters)
    }
}

public enum ListAppsVisibleToInvitedUser {

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

extension ListAppsVisibleToInvitedUser.Field {
    
    public enum App: String, CaseIterable, NestableQueryParameter {
        case betaAppLocalizations, betaAppReviewDetail, betaGroups, betaLicenseAgreement, betaTesters, builds, bundleId, name, preReleaseVersions, primaryLocale, sku

        static var key: String = "app"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
