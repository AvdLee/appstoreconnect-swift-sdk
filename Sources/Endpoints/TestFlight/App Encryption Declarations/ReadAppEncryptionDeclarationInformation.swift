//
//  ReadAppEncryptionDeclarationInformation.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == AppEncryptionDeclarationResponse {

    /// Get information about a specific app encryption declaration.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    
    ///   - fields: Fields to return for included related types.
    ///   - include: Relationship data to include in the response.
    public static func appEncryptionDeclaration(
        withId id: String,
        fields: [ReadAppEncryptionDeclarationInformation.Field]? = nil,
        include: [ReadAppEncryptionDeclarationInformation.Include]? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let include = include { parameters.add(include) }
        return APIEndpoint(path: "appEncryptionDeclarations/\(id)", method: .get, parameters: parameters)
    }
}

public struct ReadAppEncryptionDeclarationInformation {
    
    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case appEncryptionDeclarations([AppEncryptionDeclaration])
        case apps([App])
        
        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .appEncryptionDeclarations(let value):
                return (AppEncryptionDeclaration.key, value.map({ $0.pair.value }).joinedByCommas())
            case .apps(let value):
                return (App.key, value.map({ $0.pair.value }).joinedByCommas())
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

extension ReadAppEncryptionDeclarationInformation.Field {
    
    public enum AppEncryptionDeclaration: String, CaseIterable, NestableQueryParameter {
        case app, appEncryptionDeclarationState, availableOnFrenchStore, builds, codeValue, containsProprietaryCryptography, containsThirdPartyCryptography, documentName, documentType, documentUrl, exempt, platform, uploadedDate, usesEncryption

        static var key: String = "appEncryptionDeclaration"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum App: String, CaseIterable, NestableQueryParameter {
        case betaAppLocalizations, betaAppReviewDetail, betaGroups, betaLicenseAgreement, betaTesters, builds, bundleId, name, preReleaseVersions, primaryLocale, sku

        static var key: String = "app"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
