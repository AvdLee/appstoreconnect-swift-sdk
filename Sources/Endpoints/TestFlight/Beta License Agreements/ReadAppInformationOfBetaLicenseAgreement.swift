//
//  ReadAppInformationOfBetaLicenseAgreement.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == AppResponse {

    /// Get the app information for a specific beta license agreement.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.

    ///   - fields: Fields to return for included related types.
    public static func app(
        ofBetaLicenseAgreementWithId id: String,
        fields: [ReadAppInformationOfBetaLicenseAgreement.Field]? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        return APIEndpoint(
            path: "betaLicenseAgreements/\(id)/app",
            method: .get,
            parameters: parameters)
    }
}

public enum ReadAppInformationOfBetaLicenseAgreement {

    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case apps([App])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .apps(let value):
                return (App.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }
}

extension ReadAppInformationOfBetaLicenseAgreement.Field {

    public enum App: String, CaseIterable, NestableQueryParameter {
        case betaAppLocalizations, betaAppReviewDetail, betaGroups, betaLicenseAgreement, betaTesters, builds, bundleId, name, preReleaseVersions, primaryLocale, sku

        static var key: String = "App"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
