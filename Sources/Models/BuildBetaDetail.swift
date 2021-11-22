//
//  BuildBetaDetail.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation

/// The data structure that represents the resource.
public struct BuildBetaDetail: Codable {

    /// Attributes that describe a resource.
    public struct Attributes: Codable {

        /// A Boolean value that enables you to send test invitations to users automatically when the build is available to external groups.
        public let autoNotifyEnabled: Bool?

        /// A state that indicates if the build is available for external testing.
        public let externalBuildState: ExternalBetaState?

        /// A state that indicates if the build is available for internal testing.
        public let internalBuildState: InternalBetaState?
    }

    public struct Relationships: Codable {

        /// BuildBetaDetail.Relationships.Build
        public let build: BuildBetaDetail.Relationships.Build?
    }

    /// The resource's attributes.
    public let attributes: BuildBetaDetail.Attributes?

    /// The opaque resource ID that uniquely identifies the resource.
    public let `id`: String

    /// Navigational links to related data and included resource types and IDs.
    public let relationships: BuildBetaDetail.Relationships?

    /// The resource type.Value: buildBetaDetails
    public private(set) var type: String = "buildBetaDetails"

    /// Navigational links that include the self-link.
    public let links: ResourceLinks<BuildBetaDetailResponse>

}

// MARK: BuildBetaDetail.Relationships
extension BuildBetaDetail.Relationships {

    public struct Build: Codable {

        /// BuildBetaDetail.Relationships.Build.Data
        public let data: BuildBetaDetail.Relationships.Build.Data?

        /// BuildBetaDetail.Relationships.Build.Links
        public let links: BuildBetaDetail.Relationships.Build.Links?
    }
}

// MARK: BuildBetaDetail.Relationships.Build
extension BuildBetaDetail.Relationships.Build {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: builds
        public private(set) var type: String = "builds"
    }

    public struct Links: Codable {

        /// uri-reference
        public let related: URL?

        /// uri-reference
        public let `self`: URL?
    }
}
