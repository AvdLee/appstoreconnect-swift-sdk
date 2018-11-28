//
//  ListBuildsAssignedToBetaTester.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint where T == BuildsResponse {

    /// Get a list of builds individually assigned to a specific beta tester.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - limit: Number of resources to return.
    ///   - fields: Fields to return for included related types.
    public static func buildsAssignedToBetaTester(
        withId id: String,
        limit: Int? = nil,
        fields: [ListBuildsAssignedToBetaTester.Field]? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }
        if let fields = fields { parameters.add(fields) }
        return APIEndpoint(
            path: "betaTesters/\(id)/builds",
            method: .get,
            parameters: parameters)
    }
}

public struct ListBuildsAssignedToBetaTester {

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

extension ListBuildsAssignedToBetaTester.Field {
    
    public enum Build: String, CaseIterable, NestableQueryParameter {
        case app, appEncryptionDeclaration, betaAppReviewSubmission, betaBuildLocalizations, betaGroups, buildBetaDetail, expirationDate, expired, iconAssetToken, individualTesters, minOsVersion, preReleaseVersion, processingState, uploadedDate, usesNonExemptEncryption, version

        static var key: String = "build"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
