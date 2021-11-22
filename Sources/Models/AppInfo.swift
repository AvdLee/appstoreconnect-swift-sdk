//
//  AppInfo.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Morten Bjerg Gregersen on 23/08/2020.
//

import Foundation

/// The data structure that represents the resource.
public struct AppInfo: Codable {
    /// Attributes that describe a resource.
    public struct Attributes: Codable {
        
        /// The age rating.
        public let appStoreAgeRating: AppStoreAgeRating?
        
        /// The state of the app.
        public let appStoreState: AppStoreVersionState?
        
        /// The age rating for Brazil.
        public let brazilAgeRating: BrazilAgeRating?
        
        /// The range of ages the app is designed for.
        public let kidsAgeBand: KidsAgeBand?
    }
    
    public struct Relationships: Codable {
        public let app: AppInfo.Relationships.App?
        
        // Not implemented yet
//        public let appInfoLocalizations: AppInfo.Relationships.AppInfoLocalizations?
//        public let primaryCategory: AppInfo.Relationships.PrimaryCategory?
//        public let primarySubcategoryOne: AppInfo.Relationships.PrimarySubcategoryOne?
//        public let primarySubcategoryTwo: AppInfo.Relationships.PrimarySubcategoryTwo?
//        public let secondaryCategory: AppInfo.Relationships.SecondaryCategory?
//        public let secondarySubcategoryOne: AppInfo.Relationships.SecondarySubcategoryOne?
//        public let secondarySubcategoryTwo: AppInfo.Relationships.SecondarySubcategoryTwo?
    }
    
    /// The resource's attributes.
    public let attributes: AppInfo.Attributes?
    
    /// The opaque resource ID that uniquely identifies the resource.
    public let id: String
    
    /// Navigational links to related data and included resource types and IDs.
    public let relationships: AppInfo.Relationships?
    
    /// The resource type.Value: apps
    public private(set) var type: String = "appInfos"
    
//    /// Navigational links that include the self-link.
    public let links: ResourceLinks<AppInfo>
}

// MARK: AppInfo.Relationships
extension AppInfo.Relationships {
    
    public struct App: Codable {
        
        /// AppInfo.Relationships.App.Data
        public let data: AppInfo.Relationships.App.Data
        
         /// AppInfo.Relationships.App.Links
        public let links: AppInfo.Relationships.App.Links?
    }
}

// MARK: AppInfo.Relationships.App
extension AppInfo.Relationships.App {
    
    public struct Data: Codable {
        
        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
        
        /// The resource type.Value: appStoreVersions
        public private(set) var type: String = "apps"
    }
    
    public struct Links: Codable {
        
        /// uri-reference
        public let related: URL?
        
        /// uri-reference
        public let `self`: URL?
    }
}
