//
//  BuildBetaDetail.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// The data structure that represents the resource.
struct BuildBetaDetail: Decodable {

    /// The resource's attributes.
    let attributes: BuildBetaDetail.Attributes?

    /// (Required) The opaque resource ID that uniquely identifies the resource.
    let `id`: String

    /// Navigational links to related data and included resource types and IDs.
    let relationships: BuildBetaDetail.Relationships?

    /// (Required) The resource type.Value: buildBetaDetails
    let type: String

    /// (Required) Navigational links that include the self-link.
    let links: ResourceLinks

    /// Attributes that describe a resource.
    struct Attributes: Decodable {
    
        /// A Boolean value that enables you to send test invitations to users automatically when the build is available to external groups.
        let autoNotifyEnabled: Bool?
    
        /// A state that indicates if the build is available for external testing.
        let externalBuildState: ExternalBetaState?
    
        /// A state that indicates if the build is available for internal testing.
        let internalBuildState: InternalBetaState?
    }
    
    struct Relationships: Decodable {
    
        /// BuildBetaDetail.Relationships.Build
        let build: BuildBetaDetail.Relationships.Build?
    }
}

extension BuildBetaDetail.Relationships {
    
    struct Build: Decodable {
    
        /// BuildBetaDetail.Relationships.Build.Data
        let data: BuildBetaDetail.Relationships.Build.Data?
    
        /// BuildBetaDetail.Relationships.Build.Links
        let links: BuildBetaDetail.Relationships.Build.Links?
    }
}

extension BuildBetaDetail.Relationships.Build {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: builds
        let type: String
    }
    
    struct Links: Decodable {
    
        /// uri-reference
        let related: URL?
    
        /// uri-reference
        let `self`: URL?
    }
}
