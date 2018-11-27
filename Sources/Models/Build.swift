//
//  Build.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
public struct Build: Codable {

    /// The resource's attributes.
    public let attributes: Build.Attributes?

    /// (Required) The opaque resource ID that uniquely identifies the resource.
    public let `id`: String

    /// Navigational links to related data and included resource types and IDs.
    public let relationships: Build.Relationships?

    /// (Required) The resource type.Value: builds
    public let type: String

    /// (Required) Navigational links that include the self-link.
    public let links: ResourceLinks<BuildResponse>

    /// Attributes that describe a resource.
    public struct Attributes: Codable {
    
        /// A Boolean value that indicates if the build has expired. An expired build is unavailable for testing.
        public let expired: Bool?
    
        /// The icon of the uploaded build.
        public let iconAssetToken: ImageAsset?
    
        /// The minimum operating system version needed to test a build.
        public let minOsVersion: String?
    
        /// The processing state of the build indicating that it is not yet available for testing. Possible values: PROCESSING, FAILED, INVALID, VALID
        public let processingState: String?
    
        /// The version number of the uploaded build.
        public let version: String?
    
        /// A Boolean value that indicates whether the build uses non-exempt encryption.
        public let usesNonExemptEncryption: Bool?
    
        /// The date and time the build was uploaded to App Store Connect.
        public let uploadedDate: Date?
    
        /// The date and time the build  will auto-expire and no longer be available for testing.
        public let expirationDate: Date?
    }
    
    public struct Relationships: Codable {
    
        /// Build.Relationships.App
        public let app: Build.Relationships.App?
    
        /// Build.Relationships.AppEncryptionDeclaration
        public let appEncryptionDeclaration: Build.Relationships.AppEncryptionDeclaration?
    
        /// Build.Relationships.IndividualTesters
        public let individualTesters: Build.Relationships.IndividualTesters?
    
        /// Build.Relationships.PreReleaseVersion
        public let preReleaseVersion: Build.Relationships.PreReleaseVersion?
    
        /// Build.Relationships.BetaBuildLocalizations
        public let betaBuildLocalizations: Build.Relationships.BetaBuildLocalizations?
    
        /// Build.Relationships.BetaGroups
        public let betaGroups: Build.Relationships.BetaGroups?
    
        /// Build.Relationships.BuildBetaDetail
        public let buildBetaDetail: Build.Relationships.BuildBetaDetail?
    
        /// Build.Relationships.BetaAppReviewSubmission
        public let betaAppReviewSubmission: Build.Relationships.BetaAppReviewSubmission?
    }
}

/// MARK: Build.Relationships

/// MARK: Build.Relationships
extension Build.Relationships {
    
    public struct App: Codable {
    
        /// Build.Relationships.App.Data
        public let data: Build.Relationships.App.Data?
    
        /// Build.Relationships.App.Links
        public let links: Build.Relationships.App.Links?
    }
    
    public struct AppEncryptionDeclaration: Codable {
    
        /// Build.Relationships.AppEncryptionDeclaration.Data
        public let data: Build.Relationships.AppEncryptionDeclaration.Data?
    
        /// Build.Relationships.AppEncryptionDeclaration.Links
        public let links: Build.Relationships.AppEncryptionDeclaration.Links?
    }
    
    public struct BetaAppReviewSubmission: Codable {
    
        /// Build.Relationships.BetaAppReviewSubmission.Data
        public let data: Build.Relationships.BetaAppReviewSubmission.Data?
    
        /// Build.Relationships.BetaAppReviewSubmission.Links
        public let links: Build.Relationships.BetaAppReviewSubmission.Links?
    }
    
    public struct BetaBuildLocalizations: Codable {
    
        /// [Build.Relationships.BetaBuildLocalizations.Data]
        public let data: [Build.Relationships.BetaBuildLocalizations.Data]?
    
        /// Build.Relationships.BetaBuildLocalizations.Links
        public let links: Build.Relationships.BetaBuildLocalizations.Links?
    
        /// PagingInformation
        public let meta: PagingInformation?
    }
    
    public struct BetaGroups: Codable {
    
        /// [Build.Relationships.BetaGroups.Data]
        public let data: [Build.Relationships.BetaGroups.Data]?
    
        /// Build.Relationships.BetaGroups.Links
        public let links: Build.Relationships.BetaGroups.Links?
    
        /// PagingInformation
        public let meta: PagingInformation?
    }
    
    public struct BuildBetaDetail: Codable {
    
        /// Build.Relationships.BuildBetaDetail.Data
        public let data: Build.Relationships.BuildBetaDetail.Data?
    
        /// Build.Relationships.BuildBetaDetail.Links
        public let links: Build.Relationships.BuildBetaDetail.Links?
    }
    
    public struct IndividualTesters: Codable {
    
        /// [Build.Relationships.IndividualTesters.Data]
        public let data: [Build.Relationships.IndividualTesters.Data]?
    
        /// Build.Relationships.IndividualTesters.Links
        public let links: Build.Relationships.IndividualTesters.Links?
    
        /// PagingInformation
        public let meta: PagingInformation?
    }
    
    public struct PreReleaseVersion: Codable {
    
        /// Build.Relationships.PreReleaseVersion.Data
        public let data: Build.Relationships.PreReleaseVersion.Data?
    
        /// Build.Relationships.PreReleaseVersion.Links
        public let links: Build.Relationships.PreReleaseVersion.Links?
    }
}

/// MARK: Build.Relationships.App
extension Build.Relationships.App {
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: apps
        public let type: String
    }
}

/// MARK: Build.Relationships.App
extension Build.Relationships.App {
    
    public struct Links: Codable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}

/// MARK: Build.Relationships.AppEncryptionDeclaration
extension Build.Relationships.AppEncryptionDeclaration {
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: appEncryptionDeclarations
        public let type: String
    }
}

/// MARK: Build.Relationships.AppEncryptionDeclaration
extension Build.Relationships.AppEncryptionDeclaration {
    
    public struct Links: Codable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}

/// MARK: Build.Relationships.BetaAppReviewSubmission
extension Build.Relationships.BetaAppReviewSubmission {
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: betaAppReviewSubmissions
        public let type: String
    }
}

/// MARK: Build.Relationships.BetaAppReviewSubmission
extension Build.Relationships.BetaAppReviewSubmission {
    
    public struct Links: Codable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}

/// MARK: Build.Relationships.BetaBuildLocalizations
extension Build.Relationships.BetaBuildLocalizations {
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: betaBuildLocalizations
        public let type: String
    }
}

/// MARK: Build.Relationships.BetaBuildLocalizations
extension Build.Relationships.BetaBuildLocalizations {
    
    public struct Links: Codable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}

/// MARK: Build.Relationships.BetaGroups
extension Build.Relationships.BetaGroups {
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: betaGroups
        public let type: String
    }
}

/// MARK: Build.Relationships.BetaGroups
extension Build.Relationships.BetaGroups {
    
    public struct Links: Codable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}

/// MARK: Build.Relationships.BuildBetaDetail
extension Build.Relationships.BuildBetaDetail {
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: buildBetaDetails
        public let type: String
    }
}

/// MARK: Build.Relationships.BuildBetaDetail
extension Build.Relationships.BuildBetaDetail {
    
    public struct Links: Codable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}

/// MARK: Build.Relationships.IndividualTesters
extension Build.Relationships.IndividualTesters {
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: betaTesters
        public let type: String
    }
}

/// MARK: Build.Relationships.IndividualTesters
extension Build.Relationships.IndividualTesters {
    
    public struct Links: Codable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}

/// MARK: Build.Relationships.PreReleaseVersion
extension Build.Relationships.PreReleaseVersion {
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: preReleaseVersions
        public let type: String
    }
}

/// MARK: Build.Relationships.PreReleaseVersion
extension Build.Relationships.PreReleaseVersion {
    
    public struct Links: Codable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}
