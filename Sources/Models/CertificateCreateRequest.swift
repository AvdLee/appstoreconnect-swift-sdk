//
//  CertificateCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/15/19.
//

/// A request containing a single resource.
public struct CertificateCreateRequest: Encodable {

    /// The resource data.
    public let data: Data

    public struct Data: Encodable {
        public let attributes: Attributes
        public let type: String = "certificates"
    }
}

// MARK: CertificateCreateRequest.Data
extension CertificateCreateRequest.Data {

    public struct Attributes: Encodable {
        public let certificateType: CertificateType
        public let csrContent: String
    }
}
