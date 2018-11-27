//
//  GetBetaAppReviewDetailsResourceOfApp.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint where T == BetaAppReviewDetailResponse {

    /// Get the beta app review details for a specific app.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - fields: Fields to return for included related types.
    public static func betaAppReviewDetailsResourceOfApp(
        withId id: String,
        fields: [GetBetaAppReviewDetailsResourceForApp.Field]? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        return APIEndpoint(
            path: "apps/\(id)/betaAppReviewDetail",
            method: .get,
            parameters: parameters)
    }
}

public struct GetBetaAppReviewDetailsResourceForApp {

    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case betaAppReviewDetails([BetaAppReviewDetail])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .betaAppReviewDetails(let value):
                return (BetaAppReviewDetail.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }
}

extension GetBetaAppReviewDetailsResourceForApp.Field {
    
    public enum BetaAppReviewDetail: String, CaseIterable, NestableQueryParameter {
        case app, contactEmail, contactFirstName, contactLastName, contactPhone, demoAccountName, demoAccountPassword, demoAccountRequired, notes

        static var key: String = "betaAppReviewDetail"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
