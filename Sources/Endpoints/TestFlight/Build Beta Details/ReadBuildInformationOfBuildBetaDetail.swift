//
//  ReadBuildInformationOfBuildBetaDetail.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == BuildResponse {

    /// Get the build information for a specific build beta details resource.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    
    ///   - fields: Fields to return for included related types.
    public static func build(
        ofBuildBetaDetailWithId id: String,
        fields: [ReadBuildInformationOfBuildBetaDetail.Field]? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        return APIEndpoint(
            path: "buildBetaDetails/\(id)/build",
            method: .get,
            parameters: parameters)
    }
}

public enum ReadBuildInformationOfBuildBetaDetail {

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

extension ReadBuildInformationOfBuildBetaDetail.Field {
    
    public enum Build: String, CaseIterable, NestableQueryParameter {
        case app, appEncryptionDeclaration, betaAppReviewSubmission, betaBuildLocalizations, betaGroups, buildBetaDetail, expirationDate, expired, iconAssetToken, individualTesters, minOsVersion, preReleaseVersion, processingState, uploadedDate, usesNonExemptEncryption, version

        static var key: String = "build"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
