//
//  ReadAppEncryptionDeclarationOfBuild.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//
    

extension APIEndpoint where T == AppEncryptionDeclarationResponse {

    /// Read an app encryption declaration associated with a specific build.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - fields: Fields to return for included related types.
    public static func appEncryptionDeclaration(
        ofBuildWithId id: String,
        fields: [ReadAppEncryptionDeclarationOfBuild.Field]? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        return APIEndpoint(
            path: "builds/\(id)/appEncryptionDeclaration",
            method: .get,
            parameters: parameters)
    }
}

public struct ReadAppEncryptionDeclarationOfBuild {

    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case appEncryptionDeclarations([AppEncryptionDeclaration])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .appEncryptionDeclarations(let value):
                return (AppEncryptionDeclaration.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }
}

extension ReadAppEncryptionDeclarationOfBuild.Field {
    
    public enum AppEncryptionDeclaration: String, CaseIterable, NestableQueryParameter {
        case app, appEncryptionDeclarationState, availableOnFrenchStore, builds, codeValue, containsProprietaryCryptography, containsThirdPartyCryptography, documentName, documentType, documentUrl, exempt, platform, uploadedDate, usesEncryption

        static var key: String = "AppEncryptionDeclaration"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
