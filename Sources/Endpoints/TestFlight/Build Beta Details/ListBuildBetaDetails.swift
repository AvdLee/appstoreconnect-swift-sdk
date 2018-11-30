//
//  ListBuildBetaDetails.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//
    
import Alamofire

extension APIEndpoint where T == BuildBetaDetailsResponse {

    /// Find and list build beta details for all builds.
    ///
    /// - Parameters:
    ///   - fields: Fields to return for included related types.
    ///   - filter: Attributes, relationships, and IDs by which to filter.
    ///   - include: Relationship data to include in the response.
    ///   - limit: Number of resources to return.
    public static func buildBetaDetails(
        fields: [ListBuildBetaDetails.Field]? = nil,
        filter: [ListBuildBetaDetails.Filter]? = nil,
        include: [ListBuildBetaDetails.Include]? = nil,
        limit: Int? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let filter = filter { parameters.add(filter) }
        if let include = include { parameters.add(include) }
        if let limit = limit { parameters["limit"] = limit }
        return APIEndpoint(path: "buildBetaDetails", method: .get, parameters: parameters)
    }
}

public struct ListBuildBetaDetails {

    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case buildBetaDetails([BuildBetaDetail])
        case builds([Build])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .buildBetaDetails(let value):
                return (BuildBetaDetail.key, value.map({ $0.pair.value }).joinedByCommas())
            case .builds(let value):
                return (Build.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }
    
    /// Attributes, relationships, and IDs by which to filter.
    public enum Filter: NestableQueryParameter {
        case build([String]), id([String])

        static var key: String = "filter"
        var pair: Pair {
            switch self {
            case .build(let value):
                return ("build", value.joinedByCommas())
            case .id(let value):
                return ("id", value.joinedByCommas())
            }
        }
    }
    
    /// Relationship data to include in the response.
    public enum Include: String, CaseIterable, NestableQueryParameter {
        case build

        static var key: String = "include"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}

extension ListBuildBetaDetails.Field {
    
    public enum BuildBetaDetail: String, CaseIterable, NestableQueryParameter {
        case autoNotifyEnabled, build, externalBuildState, internalBuildState

        static var key: String = "buildBetaDetail"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum Build: String, CaseIterable, NestableQueryParameter {
        case app, appEncryptionDeclaration, betaAppReviewSubmission, betaBuildLocalizations, betaGroups, buildBetaDetail, expirationDate, expired, iconAssetToken, individualTesters, minOsVersion, preReleaseVersion, processingState, uploadedDate, usesNonExemptEncryption, version

        static var key: String = "build"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
