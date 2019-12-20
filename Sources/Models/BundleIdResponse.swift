//
//  BundleIdResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Rui Costa on 07/12/2019.
//

import Foundation

/// A response containing a single resource.
public struct BundleIdResponse: Decodable {
    
    /// The resource data.
    public let data: BundleId
    
    /// The data structure that represents the resource.
    public struct BundleId: Decodable {
        
        /// The resource's attributes.
        public let attributes: Attributes?
        
        /// The opaque resource ID that uniquely identifies the resource.
        public let id: String
        
        /// Navigational links to related data and included resource types and IDs.
        public let relationships: Relationships?
        
        /// The resource type.
        public let type: String = "bundleIds"
        
        /// Navigational links that include the self-link.
        public let links: ResourceLinks
    }
}

// MARK: BundleIdResponse.BundleId
extension BundleIdResponse.BundleId {
    
    public struct Attributes: Decodable {
        public let identifier: String?
        public let name: String?
        public let platform: BundleIdPlatform?
        public let seedId: String?
    }
    
    public struct Relationships: Decodable {
        public let profiles: Profiles
        public let bundleIdCapabilities: BundleIdCapabilities
    }
    
    public struct ResourceLinks: Decodable {
        
        /// The link to the resource.
        public let `self`: URL
    }
}

// MARK: BundleIdResponse.BundleId.Relationships
extension BundleIdResponse.BundleId.Relationships {
    
    public struct Profiles: Decodable {
        public let data: [Data]?
        public let links: Links?
        public let meta: PagingInformation?
    }
    
    public struct BundleIdCapabilities: Decodable {
        public let data: [Data]?
        public let links: Links?
        public let meta: PagingInformation?
    }
}

// MARK: BundleIdResponse.BundleId.Relationships.Profiles
extension BundleIdResponse.BundleId.Relationships.Profiles {
    
    public struct Data: Decodable {
        public let id: String
        public let type: String = "profiles"
    }
    
    public struct Links: Decodable {
        public let related: URL?
        public let `self`: URL?
    }
}

// MARK: BundleIdResponse.BundleId.Relationships.BundleIdCapabilities
extension BundleIdResponse.BundleId.Relationships.BundleIdCapabilities {
    
    public struct Data: Decodable {
        public let id: String
        public let type: String = "bundleIdCapabilities"
    }
    
    public struct Links: Decodable {
        public let related: URL?
        public let `self`: URL?
    }
}
