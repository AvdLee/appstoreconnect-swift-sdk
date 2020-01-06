//
//  BundleIdCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Rui Costa on 07/12/2019.
//

/// A request containing a single resource.
public struct BundleIdCreateRequest: Encodable {

    public struct Data: Encodable {

        /// The resource's attributes.
        public let attributes: BundleIdCreateRequest.Data.Attributes?

        /// The resource type.
        public let type: String = "bundleIds"
    }
    
    /// The resource data.
    public let data: Data
}

// MARK: BundleIdCreateRequest.Data
extension BundleIdCreateRequest.Data {
    
    public struct Attributes: Encodable {
        public let identifier: String
        public let name: String
        public let platform: BundleIdPlatform
        public let seedId: String?
    }
}
