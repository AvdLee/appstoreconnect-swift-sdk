//
//  BundleIdUpdateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/22/19.
//

/// A request containing a single resource.
public struct BundleIdUpdateRequest: Encodable {

    /// - Parameters:
    ///   - id: The opaque resource ID that uniquely identifies the resource.
    init(id: String, name: String) {
        data = .init(
            attributes: .init(
                name: name),
            id: id)
    }

    /// The resource data.
    public let data: Data

    public struct Data: Encodable {

        public let attributes: Attributes

        /// The opaque resource ID that uniquely identifies the resource.
        public let `id`: String

        public let type: String = "bundleIds"
    }
}

// MARK: BundleIdUpdateRequest.Data
extension BundleIdUpdateRequest.Data {

    public struct Attributes: Encodable {
        public let name: String
    }
}
