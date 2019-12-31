//
//  BundleIdUpdateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Rui Costa on 30/12/2019.
//

import Foundation

/// A request containing a single resource.
public struct BundleIdUpdateRequest: Encodable {
    
    public struct Data: Encodable {
        public let id: String
        public let attributes: Attributes
        public let type: String = "bundleIds"
    }
    
    /// The resource data.
    public let data: Data
}

// MARK: BundleIdUpdateRequest.Data
extension BundleIdUpdateRequest.Data {
    
    public struct Attributes: Encodable {
        public let name: String
    }
}
