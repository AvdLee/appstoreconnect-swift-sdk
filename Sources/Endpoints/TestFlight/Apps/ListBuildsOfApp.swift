//
//  ListBuildsOfApp.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint {

    /// Get a list of builds associated with a specific app.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - fields: Fields to return for included related types.
    ///   - limit: Number of resources to return.
    public static func buildsOfApp(
        withId id: String,
        fields: [ListBuildsOfApp.Field]? = nil,
        limit: Int? = nil) -> APIEndpoint<BuildsResponse> {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let limit = limit { parameters["limit"] = limit }
        return APIEndpoint<BuildsResponse>(
            path: "apps/\(id)/builds",
            method: .get,
            parameters: parameters)
    }
}

public struct ListBuildsOfApp {
    
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

extension ListBuildsOfApp.Field {
    
    public enum Build: String, CaseIterable, NestableQueryParameter {
        case app, appEncryptionDeclaration, betaAppReviewSubmission, betaBuildLocalizations, betaGroups, buildBetaDetail, expirationDate, expired, iconAssetToken, individualTesters, minOsVersion, preReleaseVersion, processingState, uploadedDate, usesNonExemptEncryption, version

        static var key: String = "build"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
