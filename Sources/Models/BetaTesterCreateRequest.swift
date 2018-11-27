//
//  BetaTesterCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
public struct BetaTesterCreateRequest: Codable {

    /// (Required) The resource data.
    public let data: BetaTesterCreateRequest.Data
    
    public struct Data: Codable {
    
        /// (Required) The resource's attributes.
        public let attributes: BetaTesterCreateRequest.Data.Attributes
    
        /// The types and IDs of the related data to update.
        public let relationships: BetaTesterCreateRequest.Data.Relationships?
    
        /// (Required) The resource type.Value: betaTesters
        public let type: String
    }
}

/// MARK: BetaTesterCreateRequest.Data
extension BetaTesterCreateRequest.Data {
    /// Attributes that describe a resource.
    public struct Attributes: Codable {
    
        /// (Required) The beta tester's email address, used for sending beta testing invitations.
        public let email: String
    
        /// The beta tester's first name.
        public let firstName: String?
    
        /// The beta tester's last name.
        public let lastName: String?
    }
    
    public struct Relationships: Codable {
    
        /// BetaTesterCreateRequest.Data.Relationships.BetaGroups
        public let betaGroups: BetaTesterCreateRequest.Data.Relationships.BetaGroups?
    
        /// BetaTesterCreateRequest.Data.Relationships.Builds
        public let builds: BetaTesterCreateRequest.Data.Relationships.Builds?
    }
}

/// MARK: BetaTesterCreateRequest.Data.Relationships
extension BetaTesterCreateRequest.Data.Relationships {
    
    public struct BetaGroups: Codable {
    
        /// [BetaTesterCreateRequest.Data.Relationships.BetaGroups.Data]
        public let data: [BetaTesterCreateRequest.Data.Relationships.BetaGroups.Data]?
    }

    public struct Builds: Codable {
    
        /// [BetaTesterCreateRequest.Data.Relationships.Builds.Data]
        public let data: [BetaTesterCreateRequest.Data.Relationships.Builds.Data]?
    }
}

/// MARK: BetaTesterCreateRequest.Data.Relationships.BetaGroups
extension BetaTesterCreateRequest.Data.Relationships.BetaGroups {
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: betaGroups
        public let type: String
    }
}

/// MARK: BetaTesterCreateRequest.Data.Relationships.Builds
extension BetaTesterCreateRequest.Data.Relationships.Builds {
    
    public struct Data: Codable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: builds
        public let type: String
    }
}
