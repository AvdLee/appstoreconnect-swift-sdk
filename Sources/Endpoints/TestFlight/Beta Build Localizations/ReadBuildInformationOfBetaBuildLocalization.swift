//
//  ReadBuildInformationOfBetaBuildLocalization.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == BuildResponse {

    /// Get the build information for a specific beta build localization.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - fields: Fields to return for included related types.
    public static func build(
        ofBetaBuildLocalizationWithId id: String,
        fields: [BuildInformationOfBetaBuildLocalization.Field]? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        return APIEndpoint(
            path: "betaBuildLocalizations/\(id)/build",
            method: .get,
            parameters: parameters)
    }
}

public struct BuildInformationOfBetaBuildLocalization {

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

extension BuildInformationOfBetaBuildLocalization.Field {
    
    public enum Build: String, CaseIterable, NestableQueryParameter {
        case app, appEncryptionDeclaration, betaAppReviewSubmission, betaBuildLocalizations, betaGroups, buildBetaDetail, expirationDate, expired, iconAssetToken, individualTesters, minOsVersion, preReleaseVersion, processingState, uploadedDate, usesNonExemptEncryption, version

        static var key: String = "build"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
