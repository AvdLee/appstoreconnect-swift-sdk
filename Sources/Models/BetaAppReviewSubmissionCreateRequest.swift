//
//  BetaAppReviewSubmissionCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation

/// A request containing a single resource.
public struct BetaAppReviewSubmissionCreateRequest: Codable {

    public struct Data: Codable {

        /// The types and IDs of the related data to update.
        public let relationships: BetaAppReviewSubmissionCreateRequest.Data.Relationships

        /// The resource type.Value: betaAppReviewSubmissions
        public private(set) var type: String = "betaAppReviewSubmissions"
    }

    /// The resource data.
    public let data: BetaAppReviewSubmissionCreateRequest.Data

    /// - Parameters:
    ///   - buildId: The opaque resource ID that uniquely identifies the resource.
    init(buildId: String) {
        data = .init(relationships: .init(build: .init(data: .init(id: buildId))))
    }

}

// MARK: BetaAppReviewSubmissionCreateRequest.Data
extension BetaAppReviewSubmissionCreateRequest.Data {

    public struct Relationships: Codable {

        /// BetaAppReviewSubmissionCreateRequest.Data.Relationships.Build (Required)
        public let build: BetaAppReviewSubmissionCreateRequest.Data.Relationships.Build
    }
}

// MARK: BetaAppReviewSubmissionCreateRequest.Data.Relationships
extension BetaAppReviewSubmissionCreateRequest.Data.Relationships {

    public struct Build: Codable {

        /// BetaAppReviewSubmissionCreateRequest.Data.Relationships.Build.Data (Required)
        public let data: BetaAppReviewSubmissionCreateRequest.Data.Relationships.Build.Data
    }
}

// MARK: BetaAppReviewSubmissionCreateRequest.Data.Relationships.Build
extension BetaAppReviewSubmissionCreateRequest.Data.Relationships.Build {

    public struct Data: Codable {

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.Value: builds
        public private(set) var type: String = "builds"
    }
}
