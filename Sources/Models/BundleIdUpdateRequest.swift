//
//  BundleIdUpdateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/22/19.
//

/// A request containing a single resource.
public struct BundleIdUpdateRequest: Encodable {

    public struct Data: Encodable {

        /// The resource's attributes.
        public let attributes: BundleIdUpdateRequest.Data.Attributes?

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        /// The resource type.
        public let type: String = "bundleIds"
    }

    /// The resource data.
    public let data: Data

    /// - Parameters:
    ///   - id: The opaque resource ID that uniquely identifies the resource.
    init(id: String, name: String) {
        data = .init(
            attributes: .init(
                name: name),
            id: id)
    }
}

// MARK: BundleIdUpdateRequest.Data
extension BundleIdUpdateRequest.Data {

    public struct Attributes: Encodable {
        public let name: String
    }
}
