//
//  ReadBetaAppReviewSubmissionOfBuild.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == BetaAppReviewSubmissionResponse {

    /// Get the beta app review submission status for a specific build.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    
    ///   - fields: Fields to return for included related types.
    public static func betaAppReviewSubmission(
        ofBuildWithId id: String,
        fields: [ReadBetaAppReviewSubmissionOfBuild.Field]? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        return APIEndpoint(path: "builds/\(id)/betaAppReviewSubmission", method: .get, parameters: parameters)
    }
}

public enum ReadBetaAppReviewSubmissionOfBuild {

    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case betaAppReviewSubmissions([BetaAppReviewSubmission])
        
        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .betaAppReviewSubmissions(let value):
                return (BetaAppReviewSubmission.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }
}

extension ReadBetaAppReviewSubmissionOfBuild.Field {
    
    public enum BetaAppReviewSubmission: String, CaseIterable, NestableQueryParameter {
        case betaReviewState, build

        static var key: String = "betaAppReviewSubmission"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
