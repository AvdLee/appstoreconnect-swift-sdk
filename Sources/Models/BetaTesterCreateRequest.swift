//
//  BetaTesterCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
struct BetaTesterCreateRequest: Decodable {

    /// (Required) The resource data.
    let data: BetaTesterCreateRequest.Data
    
    struct Data: Decodable {
    
        /// (Required) The resource's attributes.
        let attributes: BetaTesterCreateRequest.Data.Attributes
    
        /// The types and IDs of the related data to update.
        let relationships: BetaTesterCreateRequest.Data.Relationships?
    
        /// (Required) The resource type.Value: betaTesters
        let type: String
    }
}

/// MARK: BetaTesterCreateRequest.Data
extension BetaTesterCreateRequest.Data {
    /// Attributes that describe a resource.
    struct Attributes: Decodable {
    
        /// (Required) The beta tester's email address, used for sending beta testing invitations.
        let email: String
    
        /// The beta tester's first name.
        let firstName: String?
    
        /// The beta tester's last name.
        let lastName: String?
    }
    
    struct Relationships: Decodable {
    
        /// BetaTesterCreateRequest.Data.Relationships.BetaGroups
        let betaGroups: BetaTesterCreateRequest.Data.Relationships.BetaGroups?
    
        /// BetaTesterCreateRequest.Data.Relationships.Builds
        let builds: BetaTesterCreateRequest.Data.Relationships.Builds?
    }
}

/// MARK: BetaTesterCreateRequest.Data.Relationships
extension BetaTesterCreateRequest.Data.Relationships {
    
    struct BetaGroups: Decodable {
    
        /// [BetaTesterCreateRequest.Data.Relationships.BetaGroups.Data]
        let data: [BetaTesterCreateRequest.Data.Relationships.BetaGroups.Data]?
    }

    struct Builds: Decodable {
    
        /// [BetaTesterCreateRequest.Data.Relationships.Builds.Data]
        let data: [BetaTesterCreateRequest.Data.Relationships.Builds.Data]?
    }
}

/// MARK: BetaTesterCreateRequest.Data.Relationships.BetaGroups
extension BetaTesterCreateRequest.Data.Relationships.BetaGroups {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: betaGroups
        let type: String
    }
}

/// MARK: BetaTesterCreateRequest.Data.Relationships.Builds
extension BetaTesterCreateRequest.Data.Relationships.Builds {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: builds
        let type: String
    }
}
