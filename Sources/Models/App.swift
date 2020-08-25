//
//  App.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
public struct App: Codable {
    
    /// Attributes that describe a resource.
    public struct Attributes: Codable {
    
        /// The bundle ID for your app. This ID must match the one you use in Xcode. The bundle ID cannot be changed after you upload your first build.
        public let bundleId: String?
    
        /// The name of your app as it will appear in the App Store. The maximum length is 30 characters.
        public let name: String?
    
        /// The primary locale for your app. If localized app information isn’t available in an App Store territory, the information from your primary language is used instead.
        public let primaryLocale: String?
    
        /// A unique ID for your app that is not visible on the App Store.
        public let sku: String?
    }
    
    public struct Relationships: Codable {
    
        /// App.Relationships.AppStoreVersion
        public let appStoreVersions: App.Relationships.AppStoreVersion?
        
        /// App.Relationships.BetaLicenseAgreement
        public let betaLicenseAgreement: App.Relationships.BetaLicenseAgreement?
    
        /// App.Relationships.PreReleaseVersions
        public let preReleaseVersions: App.Relationships.PreReleaseVersions?
    
        /// App.Relationships.BetaAppLocalizations
        public let betaAppLocalizations: App.Relationships.BetaAppLocalizations?
    
        /// App.Relationships.BetaGroups
        public let betaGroups: App.Relationships.BetaGroups?
    
        /// App.Relationships.BetaTesters
        public let betaTesters: App.Relationships.BetaTesters?
    
        /// App.Relationships.Builds
        public let builds: App.Relationships.Builds?
    
        /// App.Relationships.BetaAppReviewDetail
        public let betaAppReviewDetail: App.Relationships.BetaAppReviewDetail?
    }
    
    /// The resource's attributes.
    public let attributes: App.Attributes?

    /// The opaque resource ID that uniquely identifies the resource.
    public let `id`: String

    /// Navigational links to related data and included resource types and IDs.
    public let relationships: App.Relationships?

    /// The resource type.Value: apps
    public let type: String = "apps"

    /// Navigational links that include the self-link.
    public let links: ResourceLinks<AppResponse>
}

// MARK: App.Relationships
extension App.Relationships {
    
    public struct AppStoreVersion: Codable {
        
        /// [App.Relationships.AppStoreVersion.Data]
        public let data: [App.Relationships.AppStoreVersion.Data]?
        
        /// App.Relationships.AppStoreVersion.Links
        public let links: App.Relationships.AppStoreVersion.Links?
        
        /// PagingInformation
        public let meta: PagingInformation?
    }
    
    public struct BetaAppLocalizations: Codable {
    
        /// [App.Relationships.BetaAppLocalizations.Data]
        public let data: [App.Relationships.BetaAppLocalizations.Data]?
    
        /// App.Relationships.BetaAppLocalizations.Links
        public let links: App.Relationships.BetaAppLocalizations.Links?
    
        /// PagingInformation
        public let meta: PagingInformation?
    }
    
    public struct BetaAppReviewDetail: Codable {
    
        /// App.Relationships.BetaAppReviewDetail.Data
        public let data: App.Relationships.BetaAppReviewDetail.Data?
    
        /// App.Relationships.BetaAppReviewDetail.Links
        public let links: App.Relationships.BetaAppReviewDetail.Links?
    }
    
    public struct BetaGroups: Codable {
    
        /// [App.Relationships.BetaGroups.Data]
        public let data: [App.Relationships.BetaGroups.Data]?
    
        /// App.Relationships.BetaGroups.Links
        public let links: App.Relationships.BetaGroups.Links?
    
        /// PagingInformation
        public let meta: PagingInformation?
    }
    
    public struct BetaLicenseAgreement: Codable {
    
        /// App.Relationships.BetaLicenseAgreement.Data
        public let data: App.Relationships.BetaLicenseAgreement.Data?
    
        /// App.Relationships.BetaLicenseAgreement.Links
        public let links: App.Relationships.BetaLicenseAgreement.Links?
    }
    
    public struct BetaTesters: Codable {
    
        /// [App.Relationships.BetaTesters.Data]
        public let data: [App.Relationships.BetaTesters.Data]?
    
        /// App.Relationships.BetaTesters.Links
        public let links: App.Relationships.BetaTesters.Links?
    
        /// PagingInformation
        public let meta: PagingInformation?
    }
    
    public struct Builds: Codable {
    
        /// [App.Relationships.Builds.Data]
        public let data: [App.Relationships.Builds.Data]?
    
        /// App.Relationships.Builds.Links
        public let links: App.Relationships.Builds.Links?
    
        /// PagingInformation
        public let meta: PagingInformation?
    }
    
    public struct PreReleaseVersions: Codable {
    
        /// [App.Relationships.PreReleaseVersions.Data]
        public let data: [App.Relationships.PreReleaseVersions.Data]?
    
        /// App.Relationships.PreReleaseVersions.Links
        public let links: App.Relationships.PreReleaseVersions.Links?
    
        /// PagingInformation
        public let meta: PagingInformation?
    }
}

// MARK: App.Relationships.AppStoreVersions
extension App.Relationships.AppStoreVersion {
    
    public struct Data: Codable {
        
        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
        
        /// The resource type.Value: appStoreVersions
        public let type: String = "appStoreVersions"
    }
    
    public struct Links: Codable {
        
        /// uri-reference
        public let related: URL?
        
        /// uri-reference
        public let `self`: URL?
    }
}


// MARK: App.Relationships.BetaAppLocalizations
extension App.Relationships.BetaAppLocalizations {
    
    public struct Data: Codable {
    
        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// The resource type.Value: betaAppLocalizations
        public let type: String = "betaAppLocalizations"
    }
    
    public struct Links: Codable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}

// MARK: App.Relationships.BetaAppReviewDetail
extension App.Relationships.BetaAppReviewDetail {
    
    public struct Data: Codable {
    
        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// The resource type.Value: betaAppReviewDetails
        public let type: String = "betaAppReviewDetails"
    }
    
    public struct Links: Codable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}

// MARK: App.Relationships.BetaGroups
extension App.Relationships.BetaGroups {
    
    public struct Data: Codable {
    
        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// The resource type.Value: betaGroups
        public let type: String = "betaGroups"
    }
    
    public struct Links: Codable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}

// MARK: App.Relationships.BetaLicenseAgreement
extension App.Relationships.BetaLicenseAgreement {
    
    public struct Data: Codable {
    
        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// The resource type.Value: betaLicenseAgreements
        public let type: String = "betaLicenseAgreements"
    }
    
    public struct Links: Codable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}

// MARK: App.Relationships.BetaTesters
extension App.Relationships.BetaTesters {
    
    public struct Data: Codable {
    
        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// The resource type.Value: betaTesters
        public let type: String = "betaTesters"
    }
    
    public struct Links: Codable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}

// MARK: App.Relationships.Builds
extension App.Relationships.Builds {
    
    public struct Data: Codable {
    
        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// The resource type.Value: builds
        public let type: String = "builds"
    }
    
    public struct Links: Codable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}

// MARK: App.Relationships.PreReleaseVersions
extension App.Relationships.PreReleaseVersions {
    
    public struct Data: Codable {
    
        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// The resource type.Value: preReleaseVersions
        public let type: String = "preReleaseVersions"
    }
    
    public struct Links: Codable {
    
        /// uri-reference
        public let related: URL?
    
        /// uri-reference
        public let `self`: URL?
    }
}
