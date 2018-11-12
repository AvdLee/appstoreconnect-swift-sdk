//
//  AppEncryptionDeclaration.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
struct AppEncryptionDeclaration: Decodable {

    /// The resource's attributes.
    let attributes: AppEncryptionDeclaration.Attributes?

    /// (Required) The opaque resource ID that uniquely identifies the resource.
    let `id`: String

    /// Navigational links to related data and included resource types and IDs.
    let relationships: AppEncryptionDeclaration.Relationships?

    /// (Required) The resource type.Value: appEncryptionDeclarations
    let type: String

    /// (Required) Navigational links that include the self-link.
    let links: ResourceLinks

    /// Attributes that describe a resource.
    struct Attributes: Decodable {
    
        /// A Boolean value that indicates the intent to distribute your app on the French App Store.
        let availableOnFrenchStore: Bool?
    
        /// A unique identifier that can be added to your app to associate it with a given declaration.
        let codeValue: String?
    
        /// A Boolean value that indicates your app implements any proprietary encryption algorithms.
        let containsProprietaryCryptography: Bool?
    
        /// A Boolean value that indicates your app implements any standard encryption algorithms instead of, or in addition to, using or accessing the encryption in Apple’s operating systems.
        let containsThirdPartyCryptography: Bool?
    
        /// The document name of your submitted export compliance documentation.
        let documentName: String?
    
        /// The file type of your submitted export compliance documentation.
        let documentType: String?
    
        /// The URL to the file of your submitted export compliance documentation.
        let documentUrl: String?
    
        /// A Boolean value that indicates your app is exempt based on your use of encryption and the app's availability.
        let exempt: Bool?
    
        /// The platform of the declaration.
        let platform: Platform?
    
        /// A Boolean value that indicates whether your app uses, contains, or incorporates cryptography.
        let usesEncryption: Bool?
    
        /// The approval state of your export compliance documentation.
        let appEncryptionDeclarationState: AppEncryptionDeclarationState?
    
        /// The date and time you submitted your declaration.
        let uploadedDate: Date?
    }
    
    struct Relationships: Decodable {
    
        /// AppEncryptionDeclaration.Relationships.App
        let app: AppEncryptionDeclaration.Relationships.App?
    
        /// AppEncryptionDeclaration.Relationships.Builds
        let builds: AppEncryptionDeclaration.Relationships.Builds?
    }
}

/// MARK: AppEncryptionDeclaration.Relationships
extension AppEncryptionDeclaration.Relationships {
    
    struct App: Decodable {
    
        /// AppEncryptionDeclaration.Relationships.App.Data
        let data: AppEncryptionDeclaration.Relationships.App.Data?
    
        /// AppEncryptionDeclaration.Relationships.App.Links
        let links: AppEncryptionDeclaration.Relationships.App.Links?
    }
    
    struct Builds: Decodable {
    
        /// [AppEncryptionDeclaration.Relationships.Builds.Data]
        let data: [AppEncryptionDeclaration.Relationships.Builds.Data]?
    
        /// AppEncryptionDeclaration.Relationships.Builds.Links
        let links: AppEncryptionDeclaration.Relationships.Builds.Links?
    
        /// PagingInformation
        let meta: PagingInformation?
    }
}

/// MARK: AppEncryptionDeclaration.Relationships.App
extension AppEncryptionDeclaration.Relationships.App {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: apps
        let type: String
    }
    
    struct Links: Decodable {
    
        /// uri-reference
        let related: URL?
    
        /// uri-reference
        let `self`: URL?
    }
}

/// MARK: AppEncryptionDeclaration.Relationships.Builds
extension AppEncryptionDeclaration.Relationships.Builds {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: builds
        let type: String
    }
    
    struct Links: Decodable {
    
        /// uri-reference
        let related: URL?
    
        /// uri-reference
        let `self`: URL?
    }
}
