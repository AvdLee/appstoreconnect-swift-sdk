//
//  GetBetaLicenseAgreementOfApp.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 26/11/2018.
//
    
import Alamofire

extension APIEndpoint {

    /// Get the beta license agreement for a specific app.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - fields: Fields to return for included related types.
    public static func betaLicenseAgreementOfApp(
        withId id: String,
        fields: [GetBetaLicenseAgreementForApp.Field]? = nil) -> APIEndpoint<BetaLicenseAgreementResponse> {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        return APIEndpoint<BetaLicenseAgreementResponse>(
            path: "apps/\(id)/betaLicenseAgreement",
            method: .get,
            parameters: parameters)
    }
}

public struct GetBetaLicenseAgreementForApp {

    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case betaLicenseAgreements([BetaLicenseAgreement])
        
        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .betaLicenseAgreements(let value):
                return (BetaLicenseAgreement.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }
}

extension GetBetaLicenseAgreementForApp.Field {
    
    public enum BetaLicenseAgreement: String, CaseIterable, NestableQueryParameter {
        case agreementText, app

        static var key: String = "betaLicenseAgreement"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
