//
//  ReadBetaLicenseAgreementInformation.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == BetaLicenseAgreementResponse {

    /// Get a specific beta license agreement.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - fields: Fields to return for included related types.
    ///   - include: Relationship data to include in the response.
    public static func betaLicenseAgreement(
        withId id: String,
        fields: [ReadBetaLicenseAgreementInformation.Field]? = nil,
        include: [ReadBetaLicenseAgreementInformation.Include]? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let include = include { parameters.add(include) }
        return APIEndpoint(
            path: "betaLicenseAgreements/\(id)",
            method: .get,
            parameters: parameters)
    }
}

public struct ReadBetaLicenseAgreementInformation {

    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case apps([App])
        case betaLicenseAgreements([BetaLicenseAgreement])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .apps(let value):
                return (App.key, value.map({ $0.pair.value }).joinedByCommas())
            case .betaLicenseAgreements(let value):
                return (BetaLicenseAgreement.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }
    
    /// Relationship data to include in the response.
    public enum Include: String, CaseIterable, NestableQueryParameter {
        case app

        static var key: String = "include"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}

extension ReadBetaLicenseAgreementInformation.Field {
    
    public enum App: String, CaseIterable, NestableQueryParameter {
        case betaAppLocalizations, betaAppReviewDetail, betaGroups, betaLicenseAgreement, betaTesters, builds, bundleId, name, preReleaseVersions, primaryLocale, sku

        static var key: String = "App"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum BetaLicenseAgreement: String, CaseIterable, NestableQueryParameter {
        case agreementText, app

        static var key: String = "betaLicenseAgreement"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
