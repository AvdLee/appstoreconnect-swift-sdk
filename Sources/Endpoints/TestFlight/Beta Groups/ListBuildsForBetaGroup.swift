//
//  ListBuildsForBetaGroup.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where Request == EmptyBody, Response == BuildsResponse {

    /// Get a list of builds associated with a specific beta group.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - limit: Number of resources to return.
    ///   - fields: Fields to return for included related types.
    ///   - next: The next URL to use as a base. See `PagedDocumentLinks`.
    public static func builds(
        forBetaGroupWithId id: String,
        limit: Int? = nil,
        fields: [ListBuildsForBetaGroup.Field]? = nil,
        next: PagedDocumentLinks? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }
        if let fields = fields { parameters.add(fields) }
        if let nextCursor = next?.nextCursor { parameters["cursor"] = nextCursor }
        return APIEndpoint(
            path: "betaGroups/\(id)/builds",
            method: .get,
            parameters: parameters)
    }
}

public enum ListBuildsForBetaGroup {

    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case builds([Build])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .builds(let value):
                return (Build.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }
}

extension ListBuildsForBetaGroup.Field {
    
    public enum Build: String, CaseIterable, NestableQueryParameter {
        case app, appEncryptionDeclaration, betaAppReviewSubmission, betaBuildLocalizations, betaGroups, buildBetaDetail, expirationDate, expired, iconAssetToken, individualTesters, minOsVersion, preReleaseVersion, processingState, uploadedDate, usesNonExemptEncryption, version

        static var key: String = "build"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
