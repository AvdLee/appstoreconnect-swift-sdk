//
//  BetaGroupCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation

/// A request containing a single resource.
public struct BetaGroupCreateRequest: Codable {

    public struct Data: Codable {

        /// The resource's attributes.
        public let attributes: BetaGroupCreateRequest.Data.Attributes

        /// Navigational links to related data and included resource types and IDs.
        public let relationships: BetaGroupCreateRequest.Data.Relationships

        /// The resource type.Value: betaGroups
        public private(set) var type: String = "betaGroups"
    }

    /// The resource data.
    public let data: BetaGroupCreateRequest.Data

    /// - Parameters:
    ///   - appId: The opaque resource ID that uniquely identifies the resource.
    ///   - name: The name for the beta group.
    ///   - publicLinkEnabled: A Boolean value that indicates whether a public link is enabled. Enabling a link allows you to invite anyone outside of your team to beta test your app. When you share this link, testers will be able to install the beta version of your app on their devices in TestFlight and share the link with others.
    ///   - publicLinkLimit: The maximum number of testers that can join this beta group using the public link. Values must be between 1 and 10,000.
    ///   - publicLinkLimitEnabled: A Boolean value that limits the number of testers who can join the beta group using the public link.
    ///   - betaTesterIds: Array of opaque resource ID that uniquely identifies the resources.
    ///   - buildIds: Array of opaque resource ID that uniquely identifies the resources.
    init(appId: String,
         name: String,
         publicLinkEnabled: Bool? = nil,
         publicLinkLimit: Int? = nil,
         publicLinkLimitEnabled: Bool? = nil,
         betaTesterIds: [String]? = nil,
         buildIds: [String]? = nil) {
        data = .init(
            attributes: .init(
                name: name,
                publicLinkEnabled:
                publicLinkEnabled,
                publicLinkLimit:
                publicLinkLimit,
                publicLinkLimitEnabled:
                publicLinkLimitEnabled),
            relationships: .init(
                app: .init(data: .init(id: appId)),
                betaTesters: .init(data: betaTesterIds?.map({ Data.Relationships.BetaTesters.Data(id: $0) })),
                builds: .init(data: buildIds?.map({ Data.Relationships.Builds.Data(id: $0) }))))
    }
}

// MARK: BetaGroupCreateRequest.Data
extension BetaGroupCreateRequest.Data {
    /// Attributes that describe a resource.
    public struct Attributes: Codable {

        /// The name for the beta group.
        public let name: String

        /// A Boolean value that indicates whether a public link is enabled. Enabling a link allows you to invite anyone outside of your team to beta test your app. When you share this link, testers will be able to install the beta version of your app on their devices in TestFlight and share the link with others.
        public let publicLinkEnabled: Bool?

        /// The maximum number of testers that can join this beta group using the public link. Values must be between 1 and 10,000.
        public let publicLinkLimit: Int?

        /// A Boolean value that limits the number of testers who can join the beta group using the public link.
        public let publicLinkLimitEnabled: Bool?
    }

    public struct Relationships: Codable {

        /// BetaGroupCreateRequest.Data.Relationships.App (Required)
        public let app: BetaGroupCreateRequest.Data.Relationships.App

        /// BetaGroupCreateRequest.Data.Relationships.BetaTesters
        public let betaTesters: BetaGroupCreateRequest.Data.Relationships.BetaTesters?

        /// BetaGroupCreateRequest.Data.Relationships.Builds
        public let builds: BetaGroupCreateRequest.Data.Relationships.Builds?
    }
}

// MARK: BetaGroupCreateRequest.Data.Relationships
extension BetaGroupCreateRequest.Data.Relationships {

    public struct App: Codable {

        /// BetaGroupCreateRequest.Data.Relationships.App.Data (Required)
        public let data: BetaGroupCreateRequest.Data.Relationships.App.Data
    }

    public struct BetaTesters: Codable {

        /// [BetaGroupCreateRequest.Data.Relationships.BetaTesters.Data]
        public let data: [BetaGroupCreateRequest.Data.Relationships.BetaTesters.Data]?
    }

    public struct Builds: Codable {

        /// [BetaGroupCreateRequest.Data.Relationships.Builds.Data]
        public let data: [BetaGroupCreateRequest.Data.Relationships.Builds.Data]?
    }
}

// MARK: BetaGroupCreateRequest.Data.Relationships.App
extension BetaGroupCreateRequest.Data.Relationships.App {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: apps
        public private(set) var type: String = "apps"
    }
}

// MARK: BetaGroupCreateRequest.Data.Relationships.BetaTesters
extension BetaGroupCreateRequest.Data.Relationships.BetaTesters {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: betaTesters
        public private(set) var type: String = "betaTesters"
    }
}

// MARK: BetaGroupCreateRequest.Data.Relationships.Builds
extension BetaGroupCreateRequest.Data.Relationships.Builds {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: builds
        public private(set) var type: String = "builds"
    }
}
