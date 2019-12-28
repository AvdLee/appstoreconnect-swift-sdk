//
//  CertificateCreateRequest.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/15/19.
//

/// A request containing a single resource.
public struct CertificateCreateRequest: Encodable {
    
    public struct Data: Encodable {
        public let attributes: Attributes
        public let type: String = "certificates"
    }
    
    /// The resource data.
    public let data: Data
}

// MARK: CertificateCreateRequest.Data
extension CertificateCreateRequest.Data {

    public struct Attributes: Encodable {
        public let certificateType: CertificateType
        public let csrContent: String
    }
}
