//
//  BetaTesterCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
public struct BetaTesterCreateRequest: Codable {

    /// email: The beta tester's email address, used for sending beta testing invitations.
    /// firstName: The beta tester's first name.
    /// lastName: The beta tester's last name.
    /// betaGroupIds: Array of opaque resource ID that uniquely identifies the resources.
    /// buildIds: Array of opaque resource ID that uniquely identifies the resources.
    init(email: String,
         firstName: String? = nil,
         lastName: String? = nil,
         betaGroupIds: [String]? = nil,
         buildIds: [String]? = nil) {
        
        // As of 30/11/2018, AppStoreConnectAPI does not like receiving empty arrays for relationships
        // It causes error:
        //  - code : "UNEXPECTED_ERROR"
        //  - status : "500"
        //  - id : nil
        //  - title : "An unexpected error occurred."
        //  - detail : "An unexpected error occurred on the server side. If this issue continues, contact us at https://developer.apple.com/contact/."
        //  - source : nil
        let betaGroups: Data.Relationships.BetaGroups? = betaGroupIds.flatMap({
            guard !$0.isEmpty else { return nil }
            return .init(data: $0.map({ .init(id: $0) }))
        })
        let builds: Data.Relationships.Builds? = buildIds.flatMap({
            guard !$0.isEmpty else { return nil }
            return .init(data: $0.map({ .init(id: $0) }))
        })

        data = .init(
            attributes: .init(
                email: email,
                firstName: firstName,
                lastName: lastName),
            relationships: .init(
                betaGroups: betaGroups,
                builds: builds))
    }

    /// The resource data.
    public let data: BetaTesterCreateRequest.Data
    
    public struct Data: Codable {
    
        /// The resource's attributes.
        public let attributes: BetaTesterCreateRequest.Data.Attributes
    
        /// The types and IDs of the related data to update.
        public let relationships: BetaTesterCreateRequest.Data.Relationships?
    
        /// The resource type.Value: betaTesters
        public let type: String = "betaTesters"
    }
}

/// MARK: BetaTesterCreateRequest.Data
extension BetaTesterCreateRequest.Data {
    /// Attributes that describe a resource.
    public struct Attributes: Codable {
    
        /// The beta tester's email address, used for sending beta testing invitations.
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
    
        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// The resource type.Value: betaGroups
        public let type: String = "betaGroups"
    }
}

/// MARK: BetaTesterCreateRequest.Data.Relationships.Builds
extension BetaTesterCreateRequest.Data.Relationships.Builds {
    
    public struct Data: Codable {
    
        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// The resource type.Value: builds
        public let type: String = "builds"
    }
}
