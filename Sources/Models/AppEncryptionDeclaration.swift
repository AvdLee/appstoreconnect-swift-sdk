//
//  AppEncryptionDeclaration.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
public struct AppEncryptionDeclaration: Codable {

    /// The resource's attributes.
    public let attributes: AppEncryptionDeclaration.Attributes?

    /// (Required) The opaque resource ID that uniquely identifies the resource.
    public let `id`: String

    /// Navigational links to related data and included resource types and IDs.
    public let relationships: AppEncryptionDeclaration.Relationships?

    /// (Required) The resource type.Value: appEncryptionDeclarations
    public let type: String = "appEncryptionDeclarations"

    /// (Required) Navigational links that include the self-link.
    public let links: ResourceLinks<AppEncryptionDeclarationResponse>

    /// Attributes that describe a resource.
    public struct Attributes: Codable {
    
        /// A Boolean value that indicates the intent to distribute your app on the French App Store.
        public let availableOnFrenchStore: Bool?
    
        /// A unique identifier that can be added to your app to associate it with a given declaration.
        public let codeValue: String?
    
        /// A Boolean value that indicates your app implements any proprietary encryption algorithms.
        public let containsProprietaryCryptography: Bool?
    
        /// A Boolean value that indicates your app implements any standard encryption algorithms instead of, or in addition to, using or accessing the encryption in Apple’s operating systems.
        public let containsThirdPartyCryptography: Bool?
    
        /// The document name of your submitted export compliance documentation.
        public let documentName: String?
    
        /// The file type of your submitted export compliance documentation.
        public let documentType: String?
    
        /// The URL to the file of your submitted export compliance documentation.
        public let documentUrl: String?
    
        /// A Boolean value that indicates your app is exempt based on your use of encryption and the app's availability.
        public let exempt: Bool?
    
        /// The platform of the declaration.
        public let platform: Platform?
    
        /// A Boolean value that indicates whether your app uses, contains, or incorporates cryptography.
        public let usesEncryption: Bool?
    
        /// The approval state of your export compliance documentation.
        public let appEncryptionDeclarationState: AppEncryptionDeclarationState?
    
        /// The date and time you submitted your declaration.
        public let uploadedDate: Date?
    }
    
    public struct Relationships: Codable {
    
        /// AppEncryptionDeclaration.Relationships.App
        public let app: AppEncryptionDeclaration.Relationships.App?
    
        /// AppEncryptionDeclaration.Relationships.Builds
        public let builds: AppEncryptionDeclaration.Relationships.Builds?
    }
}

/// MARK: AppEncryptionDeclaration.Relationships
extension AppEncryptionDeclaration.Relationships {
    
    public struct App: Codable {
    
        /// AppEncryptionDeclaration.Relationships.App.Data
        public let data: AppEncryptionDeclaration.Relationships.App.Data?
    
        /// AppEncryptionDeclaration.Relationships.App.Links
        public let links: AppEncryptionDeclaration.Relationships.App.Links?
    }
    
    public struct Builds: Codable {
    
        /// [AppEncryptionDeclaration.Relationships.Builds.Data]
        public let data: [AppEncryptionDeclaration.Relationships.Builds.Data]?
    
        /// AppEncryptionDeclaration.Relationships.Builds.Links
        public let links: AppEncryptionDeclaration.Relationships.Builds.Links?
    
        /// PagingInformation
        public let meta: PagingInformation?
    }
}

/// MARK: AppEncryptionDeclaration.Relationships.App
extension AppEncryptionDeclaration.Relationships.App {
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: apps
        public let type: String = " apps"
    }
    
    public struct Links: Codable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}

/// MARK: AppEncryptionDeclaration.Relationships.Builds
extension AppEncryptionDeclaration.Relationships.Builds {
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: builds
        public let type: String = " builds"
    }
    
    public struct Links: Codable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}
