//
//  CreateCertificate.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/15/19.
//

import Foundation

extension APIEndpoint where Request == CertificateCreateRequest, Response == CertificateResponse {

    /// Create a new certificate using a certificate signing request.
    ///
    /// - Parameters:
    ///   - certificateType: (Required) The type of certificate to be created.
    ///   - csrContent: (Required) The certificate signing request to be used to create the certificate.
    public static func create(
        certificateWithCertificateType certificateType: CertificateType,
        csrContent: String) -> APIEndpoint {

        let request = CertificateCreateRequest(data: .init(
            attributes: .init(
            certificateType: certificateType,
            csrContent: csrContent)))

        return APIEndpoint(
            path: "certificates",
            method: .post,
            parameters: nil,
            body: request)
    }
}
