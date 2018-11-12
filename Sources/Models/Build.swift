//
//  Build.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
struct Build: Decodable {

    /// The resource's attributes.
    let attributes: Build.Attributes?

    /// (Required) The opaque resource ID that uniquely identifies the resource.
    let `id`: String

    /// Navigational links to related data and included resource types and IDs.
    let relationships: Build.Relationships?

    /// (Required) The resource type.Value: builds
    let type: String

    /// (Required) Navigational links that include the self-link.
    let links: ResourceLinks

    /// Attributes that describe a resource.
    struct Attributes: Decodable {
    
        /// A Boolean value that indicates if the build has expired. An expired build is unavailable for testing.
        let expired: Bool?
    
        /// The icon of the uploaded build.
        let iconAssetToken: ImageAsset?
    
        /// The minimum operating system version needed to test a build.
        let minOsVersion: String?
    
        /// The processing state of the build indicating that it is not yet available for testing. Possible values: PROCESSING, FAILED, INVALID, VALID
        let processingState: String?
    
        /// The version number of the uploaded build.
        let version: String?
    
        /// A Boolean value that indicates whether the build uses non-exempt encryption.
        let usesNonExemptEncryption: Bool?
    
        /// The date and time the build was uploaded to App Store Connect.
        let uploadedDate: Date?
    
        /// The date and time the build  will auto-expire and no longer be available for testing.
        let expirationDate: Date?
    }
    
    struct Relationships: Decodable {
    
        /// Build.Relationships.App
        let app: Build.Relationships.App?
    
        /// Build.Relationships.AppEncryptionDeclaration
        let appEncryptionDeclaration: Build.Relationships.AppEncryptionDeclaration?
    
        /// Build.Relationships.IndividualTesters
        let individualTesters: Build.Relationships.IndividualTesters?
    
        /// Build.Relationships.PreReleaseVersion
        let preReleaseVersion: Build.Relationships.PreReleaseVersion?
    
        /// Build.Relationships.BetaBuildLocalizations
        let betaBuildLocalizations: Build.Relationships.BetaBuildLocalizations?
    
        /// Build.Relationships.BetaGroups
        let betaGroups: Build.Relationships.BetaGroups?
    
        /// Build.Relationships.BuildBetaDetail
        let buildBetaDetail: Build.Relationships.BuildBetaDetail?
    
        /// Build.Relationships.BetaAppReviewSubmission
        let betaAppReviewSubmission: Build.Relationships.BetaAppReviewSubmission?
    }
}

/// MARK: Build.Relationships

extension Build.Relationships {
    
    struct App: Decodable {
    
        /// Build.Relationships.App.Data
        let data: Build.Relationships.App.Data?
    
        /// Build.Relationships.App.Links
        let links: Build.Relationships.App.Links?
    }
    
    struct AppEncryptionDeclaration: Decodable {
    
        /// Build.Relationships.AppEncryptionDeclaration.Data
        let data: Build.Relationships.AppEncryptionDeclaration.Data?
    
        /// Build.Relationships.AppEncryptionDeclaration.Links
        let links: Build.Relationships.AppEncryptionDeclaration.Links?
    }
    
    struct BetaAppReviewSubmission: Decodable {
    
        /// Build.Relationships.BetaAppReviewSubmission.Data
        let data: Build.Relationships.BetaAppReviewSubmission.Data?
    
        /// Build.Relationships.BetaAppReviewSubmission.Links
        let links: Build.Relationships.BetaAppReviewSubmission.Links?
    }
    
    struct BetaBuildLocalizations: Decodable {
    
        /// [Build.Relationships.BetaBuildLocalizations.Data]
        let data: [Build.Relationships.BetaBuildLocalizations.Data]?
    
        /// Build.Relationships.BetaBuildLocalizations.Links
        let links: Build.Relationships.BetaBuildLocalizations.Links?
    
        /// PagingInformation
        let meta: PagingInformation?
    }
    
    struct BetaGroups: Decodable {
    
        /// [Build.Relationships.BetaGroups.Data]
        let data: [Build.Relationships.BetaGroups.Data]?
    
        /// Build.Relationships.BetaGroups.Links
        let links: Build.Relationships.BetaGroups.Links?
    
        /// PagingInformation
        let meta: PagingInformation?
    }
    
    struct BuildBetaDetail: Decodable {
    
        /// Build.Relationships.BuildBetaDetail.Data
        let data: Build.Relationships.BuildBetaDetail.Data?
    
        /// Build.Relationships.BuildBetaDetail.Links
        let links: Build.Relationships.BuildBetaDetail.Links?
    }
    
    struct IndividualTesters: Decodable {
    
        /// [Build.Relationships.IndividualTesters.Data]
        let data: [Build.Relationships.IndividualTesters.Data]?
    
        /// Build.Relationships.IndividualTesters.Links
        let links: Build.Relationships.IndividualTesters.Links?
    
        /// PagingInformation
        let meta: PagingInformation?
    }
    
    struct PreReleaseVersion: Decodable {
    
        /// Build.Relationships.PreReleaseVersion.Data
        let data: Build.Relationships.PreReleaseVersion.Data?
    
        /// Build.Relationships.PreReleaseVersion.Links
        let links: Build.Relationships.PreReleaseVersion.Links?
    }
}

extension Build.Relationships.App {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: apps
        let type: String
    }
}

extension Build.Relationships.App {
    
    struct Links: Decodable {
    
        /// uri-reference
        let related: URL?
    
        /// uri-reference
        let `self`: URL?
    }
}

extension Build.Relationships.AppEncryptionDeclaration {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: appEncryptionDeclarations
        let type: String
    }
}

extension Build.Relationships.AppEncryptionDeclaration {
    
    struct Links: Decodable {
    
        /// uri-reference
        let related: URL?
    
        /// uri-reference
        let `self`: URL?
    }
}

extension Build.Relationships.BetaAppReviewSubmission {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: betaAppReviewSubmissions
        let type: String
    }
}

extension Build.Relationships.BetaAppReviewSubmission {
    
    struct Links: Decodable {
    
        /// uri-reference
        let related: URL?
    
        /// uri-reference
        let `self`: URL?
    }
}

extension Build.Relationships.BetaBuildLocalizations {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: betaBuildLocalizations
        let type: String
    }
}

extension Build.Relationships.BetaBuildLocalizations {
    
    struct Links: Decodable {
    
        /// uri-reference
        let related: URL?
    
        /// uri-reference
        let `self`: URL?
    }
}

extension Build.Relationships.BetaGroups {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: betaGroups
        let type: String
    }
}

extension Build.Relationships.BetaGroups {
    
    struct Links: Decodable {
    
        /// uri-reference
        let related: URL?
    
        /// uri-reference
        let `self`: URL?
    }
}

extension Build.Relationships.BuildBetaDetail {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: buildBetaDetails
        let type: String
    }
}

extension Build.Relationships.BuildBetaDetail {
    
    struct Links: Decodable {
    
        /// uri-reference
        let related: URL?
    
        /// uri-reference
        let `self`: URL?
    }
}

extension Build.Relationships.IndividualTesters {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: betaTesters
        let type: String
    }
}

extension Build.Relationships.IndividualTesters {
    
    struct Links: Decodable {
    
        /// uri-reference
        let related: URL?
    
        /// uri-reference
        let `self`: URL?
    }
}

extension Build.Relationships.PreReleaseVersion {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: preReleaseVersions
        let type: String
    }
}

extension Build.Relationships.PreReleaseVersion {
    
    struct Links: Decodable {
    
        /// uri-reference
        let related: URL?
    
        /// uri-reference
        let `self`: URL?
    }
}
