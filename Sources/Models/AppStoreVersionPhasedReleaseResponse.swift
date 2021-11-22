//
//  AppStoreVersionPhasedReleaseResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by James Sherlock on 14/12/2020.
//

import Foundation

public struct AppStoreVersionPhasedReleaseResponse: Codable {
    
    public struct Attributes: Codable {
        
        /// The number of days since the release was started.
        public let currentDayNumber: Int?
        
        /// The current state of the release of this version.
        public let phasedReleaseState: PhasedReleaseState?
        
        /// The start date for the release of this version.
        public let startDate: Date?
        
        /// The total amount of days the app store version has been paused for.
        public let totalPauseDuration: Int?
    }
    
    public struct Data: Codable {
        
        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
        
        /// The resource's attributes.
        public let attributes: Attributes?
        
        /// The resource type.Value: appStoreVersionPhasedReleases
        public private(set) var type: String = "appStoreVersionPhasedReleases"
        
    }
    
    /// The object types and IDs of the related resources.
    public let data: Data
    
    /// Navigational links including the self-link and links to the related data.
    public let links: PagedDocumentLinks
    
}
