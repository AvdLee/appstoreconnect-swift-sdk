//
//  AppStoreVersion.swift
//
//
//  Created by Morten Bjerg Gregersen on 24/08/2020.
//

import Foundation

/// The data structure that represents the resource.
public struct AppStoreVersion: Codable {
    /// Attributes that describe a resource.
    public struct Attributes: Codable {
        public let platform: Platform?
        public let appStoreState: AppStoreVersionState?
        public let copyright: String?
        public let earliestReleaseDate: Date?
        public let releaseType: String?
        public let usesIdfa: Bool?
        public let versionString: String?
        public let createdDate: Date?
        public let downloadable: Bool?
    }
    
    public struct Relationships: Codable {
        public let app: AppStoreVersion.Relationships.App?
        public let ageRatingDeclaration: AppStoreVersion.Relationships.AgeRatingDeclaration?
        public let appStoreReviewDetail: AppStoreVersion.Relationships.AppStoreReviewDetail?
        public let appStoreVersionLocalizations: AppStoreVersion.Relationships.AppStoreVersionLocalizations?
        public let appStoreVersionPhasedRelease: AppStoreVersion.Relationships.AppStoreVersionPhasedRelease?
        public let appStoreVersionSubmission: AppStoreVersion.Relationships.AppStoreVersionSubmission?
        public let build: AppStoreVersion.Relationships.Build?
        public let idfaDeclaration: AppStoreVersion.Relationships.IdfaDeclaration?
        public let routingAppCoverage: AppStoreVersion.Relationships.RoutingAppCoverage?
    }
    
    /// The resource's attributes.
    public let attributes: AppStoreVersion.Attributes?
    
    /// The opaque resource ID that uniquely identifies the resource.
    public let id: String
    
    // Navigational links that include the self-link.
    public let links: ResourceLinks<AppStoreVersionResponse>

    /// Navigational links to related data and included resource types and IDs.
    public let relationships: AppStoreVersion.Relationships?
    
    /// The resource type.Value: appStoreVersions
    public let type: String = "appStoreVersions"
    
}

// MARK: AppStoreVersion.Relationships
extension AppStoreVersion.Relationships {
    public struct App: Codable {
        public let data: AppStoreVersion.Relationships.App.Data?
        public let links: AppStoreVersion.Relationships.App.Links?
        
        public struct Data: Codable {
            public let `id`: String
            public let type: String = "apps"
        }
        
        public struct Links: Codable {
            public let related: URL?
            public let `self`: URL?
        }
    }
    
    public struct AgeRatingDeclaration: Codable {
        public let data: AppStoreVersion.Relationships.AgeRatingDeclaration.Data?
        public let links: AppStoreVersion.Relationships.AgeRatingDeclaration.Links
        
        public struct Data: Codable {
            public let `id`: String
            public let type: String = "ageRatingDeclarations"
        }
        
        public struct Links: Codable {
            public let related: URL?
            public let `self`: URL?
        }
    }
    
    public struct AppStoreReviewDetail: Codable {
        public let data: AppStoreVersion.Relationships.AppStoreReviewDetail.Data?
        public let links: AppStoreVersion.Relationships.AppStoreReviewDetail.Links?
        
        public struct Data: Codable {
            public let `id`: String
            public let type: String = "appStoreReviewDetails"
        }
        
        public struct Links: Codable {
            public let related: URL?
            public let `self`: URL?
        }
    }
    
    public struct AppStoreVersionLocalizations: Codable {
        public let data: AppStoreVersion.Relationships.AppStoreVersionLocalizations.Data?
        public let links: AppStoreVersion.Relationships.AppStoreVersionLocalizations.Links?
        
        public struct Data: Codable {
            public let `id`: String
            public let type: String = "appStoreVersionLocalizations"
        }
        
        public struct Links: Codable {
            public let related: URL?
            public let `self`: URL?
        }
    }
    
    public struct AppStoreVersionPhasedRelease: Codable {
        public let data: AppStoreVersion.Relationships.AppStoreVersionPhasedRelease.Data?
        public let links: AppStoreVersion.Relationships.AppStoreVersionPhasedRelease.Links?
        
        public struct Data: Codable {
            public let `id`: String
            public let type: String = "appStoreVersionPhasedReleases"
        }
        
        public struct Links: Codable {
            public let related: URL?
            public let `self`: URL?
        }
    }
    
    public struct AppStoreVersionSubmission: Codable {
        public let data: AppStoreVersion.Relationships.AppStoreVersionSubmission.Data?
        public let links: AppStoreVersion.Relationships.AppStoreVersionSubmission.Links?
        
        public struct Data: Codable {
            public let `id`: String
            public let type: String = "appStoreVersionSubmissions"
        }
        
        public struct Links: Codable {
            public let related: URL?
            public let `self`: URL?
        }
    }
    
    public struct Build: Codable {
        public let data: AppStoreVersion.Relationships.Build.Data?
        public let links: AppStoreVersion.Relationships.Build.Links?
        
        public struct Data: Codable {
            public let `id`: String
            public let type: String = "builds"
        }
        
        public struct Links: Codable {
            public let related: URL?
            public let `self`: URL?
        }
    }
    
    public struct IdfaDeclaration: Codable {
        public let data: AppStoreVersion.Relationships.IdfaDeclaration.Data?
        public let links: AppStoreVersion.Relationships.IdfaDeclaration.Links?
        
        public struct Data: Codable {
            public let `id`: String
            public let type: String = "idfaDeclarations"
        }
        
        public struct Links: Codable {
            public let related: URL?
            public let `self`: URL?
        }
    }
    
    public struct RoutingAppCoverage: Codable {
        public let data: AppStoreVersion.Relationships.RoutingAppCoverage.Data?
        public let links: AppStoreVersion.Relationships.RoutingAppCoverage.Links?
        
        public struct Data: Codable {
            public let `id`: String
            public let type: String = "routingAppCoverages"
        }
        
        public struct Links: Codable {
            public let related: URL?
            public let `self`: URL?
        }
    }
}
