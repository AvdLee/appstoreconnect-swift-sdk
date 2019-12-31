//
//  ReadBetaAppReviewSubmissionInformation.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == BetaAppReviewSubmissionResponse {

    /// Get a specific beta app review submission.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - fields: Fields to return for included related types.
    ///   - include: Relationship data to include in the response.
    public static func betaAppReviewSubmission(
        withId id: String,
        fields: [ReadBetaAppReviewSubmissionInformation.Field]? = nil,
        include: [ReadBetaAppReviewSubmissionInformation.Include]? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let include = include { parameters.add(include) }
        return APIEndpoint(path: "betaAppReviewSubmissions/\(id)", method: .get, parameters: parameters)
    }
}

public enum ReadBetaAppReviewSubmissionInformation {
    
    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case betaAppReviewSubmissions([BetaAppReviewSubmission])
        case builds([Build])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .betaAppReviewSubmissions(let value):
                return (BetaAppReviewSubmission.key, value.map({ $0.pair.value }).joinedByCommas())
            case .builds(let value):
                return (Build.key, value.map({ $0.pair.value }).joinedByCommas())
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

extension ReadBetaAppReviewSubmissionInformation.Field {
    
    public enum BetaAppReviewSubmission: String, CaseIterable, NestableQueryParameter {
        case betaReviewState, build

        static var key: String = "betaAppReviewSubmission"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum Build: String, CaseIterable, NestableQueryParameter {
        case app, appEncryptionDeclaration, betaAppReviewSubmission, betaBuildLocalizations, betaGroups, buildBetaDetail, expirationDate, expired, iconAssetToken, individualTesters, minOsVersion, preReleaseVersion, processingState, uploadedDate, usesNonExemptEncryption, version

        static var key: String = "build"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
