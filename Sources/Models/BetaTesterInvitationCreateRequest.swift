//
//  BetaTesterInvitationCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A request containing a single resource.
struct BetaTesterInvitationCreateRequest: Decodable {

    /// (Required) The resource data.
    let data: BetaTesterInvitationCreateRequest.Data
    
    struct Data: Decodable {
    
        /// (Required) The types and IDs of the related data to update.
        let relationships: BetaTesterInvitationCreateRequest.Data.Relationships
    
        /// (Required) The resource type.Value: betaTesterInvitations
        let type: String
    }
}

extension BetaTesterInvitationCreateRequest.Data {
    
    struct Relationships: Decodable {
    
        /// BetaTesterInvitationCreateRequest.Data.Relationships.App (Required)
        let app: BetaTesterInvitationCreateRequest.Data.Relationships.App
    
        /// BetaTesterInvitationCreateRequest.Data.Relationships.BetaTester (Required)
        let betaTester: BetaTesterInvitationCreateRequest.Data.Relationships.BetaTester
    }
}

extension BetaTesterInvitationCreateRequest.Data.Relationships {
    
    struct App: Decodable {
    
        /// BetaTesterInvitationCreateRequest.Data.Relationships.App.Data (Required)
        let data: BetaTesterInvitationCreateRequest.Data.Relationships.App.Data
    }
    
    struct BetaTester: Decodable {
    
        /// BetaTesterInvitationCreateRequest.Data.Relationships.BetaTester.Data (Required)
        let data: BetaTesterInvitationCreateRequest.Data.Relationships.BetaTester.Data
    }
}

extension BetaTesterInvitationCreateRequest.Data.Relationships.App {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: apps
        let type: String
    }
}

extension BetaTesterInvitationCreateRequest.Data.Relationships.BetaTester {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: betaTesters
        let type: String
    }
}
