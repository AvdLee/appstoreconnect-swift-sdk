//
//  AppStoreVersionLocalization.swift
//
//  Created by Kirill Budevich on 1/27/21.
//

import Foundation

/// The data structure that represents the resource.
public struct AppStoreVersionLocalization: Codable {
    /// Attributes that describe a resource.
    public struct Attributes: Codable {
        public let description: String?
        public let keywords: String?
        public let locale: String?
        public let marketingUrl: URL?
        public let promotionalText: String?
        public let supportUrl: URL?
        public let whatsNew: String?
    }

    public struct Relationships: Codable {
        public let appPreviewSets: AppStoreVersionLocalization.Relationships.AppPreviewSets?
        public let appScreenshotSets: AppStoreVersionLocalization.Relationships.AppScreenshotSets?
        public let appStoreVersion: AppStoreVersionLocalization.Relationships.AppStoreVersion?
    }

    /// The resource's attributes.
    public let attributes: AppStoreVersionLocalization.Attributes?

    /// The opaque resource ID that uniquely identifies the resource.
    public let id: String

    // Navigational links that include the self-link.
    public let links: ResourceLinks<AppStoreVersionLocalizationResponse>

    /// Navigational links to related data and included resource types and IDs.
    public let relationships: AppStoreVersionLocalization.Relationships?

    /// The resource type.Value: appStoreVersionLocalizations
    public private(set) var type: String = "appStoreVersionLocalizations"

}

// MARK: AppStoreVersionLocalization.Relationships
extension AppStoreVersionLocalization.Relationships {
    public struct AppPreviewSets: Codable {
        public struct Data: Codable {
            public let `id`: String
            public private(set) var type: String = "appPreviewSets"
        }

        public struct Links: Codable {
            public let related: URL?
            public let `self`: URL?
        }

        public let data: Data?
        public let links: Links?
    }

    public struct AppScreenshotSets: Codable {
        public struct Data: Codable {
            public let `id`: String
            public private(set) var type: String = "appScreenshotSets"
        }

        public struct Links: Codable {
            public let related: URL?
            public let `self`: URL?
        }

        public let data: Data?
        public let links: Links
    }

    public struct AppStoreVersion: Codable {
        public struct Data: Codable {
            public let `id`: String
            public private(set) var type: String = "appStoreReviewDetails"
        }

        public struct Links: Codable {
            public let related: URL?
            public let `self`: URL?
        }

        public let data: Data?
        public let links: Links?
    }
}
