//
//  ListBuildsOfPrereleaseVersion.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == BuildsResponse {

    /// Get a list of builds of a specific prerelease version.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - fields: Fields to return for included related types.
    ///   - limit: Number of resources to return.
    ///   - next: The next URL to use as a base. See `PagedDocumentLinks`.
    public static func builds(
        ofPrereleaseVersionWith id: String,
        fields: [ListBuildsOfPrereleaseVersion.Field]? = nil,
        limit: Int? = nil,
        next: PagedDocumentLinks? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let limit = limit {
            parameters["limit"] = limit
        } else if let nextLimit = next?.nextLimit {
            parameters["limit"] = nextLimit
        }
        if let fields = fields { parameters.add(fields) }
        if let nextCursor = next?.nextCursor { parameters["cursor"] = nextCursor }
        return APIEndpoint(path: "preReleaseVersions/\(id)/builds", method: .get, parameters: parameters)
    }
}

public enum ListBuildsOfPrereleaseVersion {

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

extension ListBuildsOfPrereleaseVersion.Field {

    public enum Build: String, CaseIterable, NestableQueryParameter {
        case app, appEncryptionDeclaration, betaAppReviewSubmission, betaBuildLocalizations, betaGroups, buildBetaDetail, expirationDate, expired, iconAssetToken, individualTesters, minOsVersion, preReleaseVersion, processingState, uploadedDate, usesNonExemptEncryption, version

        static var key: String = "build"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
