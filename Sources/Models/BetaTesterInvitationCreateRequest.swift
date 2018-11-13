//
//  BetaTesterInvitationCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
public struct BetaTesterInvitationCreateRequest: Decodable {

    /// (Required) The resource data.
    public let data: BetaTesterInvitationCreateRequest.Data
    
    public struct Data: Decodable {
    
        /// (Required) The types and IDs of the related data to update.
        public let relationships: BetaTesterInvitationCreateRequest.Data.Relationships
    
        /// (Required) The resource type.Value: betaTesterInvitations
        public let type: String
    }
}

/// MARK: BetaTesterInvitationCreateRequest.Data
extension BetaTesterInvitationCreateRequest.Data {
    
    public struct Relationships: Decodable {
    
        /// BetaTesterInvitationCreateRequest.Data.Relationships.App (Required)
        public let app: BetaTesterInvitationCreateRequest.Data.Relationships.App
    
        /// BetaTesterInvitationCreateRequest.Data.Relationships.BetaTester (Required)
        public let betaTester: BetaTesterInvitationCreateRequest.Data.Relationships.BetaTester
    }
}

/// MARK: BetaTesterInvitationCreateRequest.Data.Relationships
extension BetaTesterInvitationCreateRequest.Data.Relationships {
    
    public struct App: Decodable {
    
        /// BetaTesterInvitationCreateRequest.Data.Relationships.App.Data (Required)
        public let data: BetaTesterInvitationCreateRequest.Data.Relationships.App.Data
    }
    
    public struct BetaTester: Decodable {
    
        /// BetaTesterInvitationCreateRequest.Data.Relationships.BetaTester.Data (Required)
        public let data: BetaTesterInvitationCreateRequest.Data.Relationships.BetaTester.Data
    }
}

/// MARK: BetaTesterInvitationCreateRequest.Data.Relationships.App
extension BetaTesterInvitationCreateRequest.Data.Relationships.App {
    
    public struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: apps
        public let type: String
    }
}

/// MARK: BetaTesterInvitationCreateRequest.Data.Relationships.BetaTester
extension BetaTesterInvitationCreateRequest.Data.Relationships.BetaTester {
    
    public struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        public let `id`: String
    
        /// (Required) The resource type.Value: betaTesters
        public let type: String
    }
}
