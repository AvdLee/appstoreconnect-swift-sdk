//
//  BuildUpdateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation

/// A request containing a single resource.
public struct BuildUpdateRequest: Codable {

    public struct Data: Codable {

        /// The resource's attributes.
        public let attributes: BuildUpdateRequest.Data.Attributes?

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// Navigational links to related data and included resource types and IDs.
        public let relationships: BuildUpdateRequest.Data.Relationships?

        /// The resource type.Value: builds
        public private(set) var type: String = "builds"
    }

    /// The resource data.
    public let data: BuildUpdateRequest.Data

    /// - Parameters:
    ///   - id: The opaque resource ID that uniquely identifies the resource.
    ///   - appEncryptionDeclarationId: The opaque resource ID that uniquely identifies the resource.
    ///   - autoNotifyEnabled: A Boolean value that enables you to send test invitations to users automatically when the build is available to external groups.
    init(id: String,
         expired: Bool? = nil,
         appEncryptionDeclarationId: String,
         usesNonExemptEncryption: Bool? = nil) {
        data = .init(
            attributes: .init(
                expired: expired,
                usesNonExemptEncryption: usesNonExemptEncryption),
            id: id,
            relationships: .init(
                appEncryptionDeclaration: .init(data: .init(id: appEncryptionDeclarationId))))
    }
}

// MARK: BuildUpdateRequest.Data
extension BuildUpdateRequest.Data {
    /// Attributes that describe a resource.
    public struct Attributes: Codable {

        /// A Boolean value that indicates if the build has expired. An expired build is unavailable for testing.
        public let expired: Bool?

        /// A Boolean value that indicates whether the build uses non-exempt encryption.
        public let usesNonExemptEncryption: Bool?
    }

    public struct Relationships: Codable {

        /// BuildUpdateRequest.Data.Relationships.AppEncryptionDeclaration
        public let appEncryptionDeclaration: BuildUpdateRequest.Data.Relationships.AppEncryptionDeclaration?
    }
}

// MARK: BuildUpdateRequest.Data.Relationships
extension BuildUpdateRequest.Data.Relationships {

    public struct AppEncryptionDeclaration: Codable {

        /// BuildUpdateRequest.Data.Relationships.AppEncryptionDeclaration.Data
        public let data: BuildUpdateRequest.Data.Relationships.AppEncryptionDeclaration.Data?
    }
}

// MARK: BuildUpdateRequest.Data.Relationships.AppEncryptionDeclaration
extension BuildUpdateRequest.Data.Relationships.AppEncryptionDeclaration {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: appEncryptionDeclarations
        public private(set) var type: String = "appEncryptionDeclarations"
    }
}
