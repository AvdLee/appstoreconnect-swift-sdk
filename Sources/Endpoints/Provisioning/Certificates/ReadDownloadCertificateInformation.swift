//
//  ReadDownloadCertificateInformation.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/14/2019.
//

import Foundation

extension APIEndpoint where T == CertificateResponse {

    /// Get information about a certificate and download the certificate data.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the certificate.
    ///   - fields: Fields to return for included related types.
    public static func readDownloadCertificate(
        withId id: String,
        fields: [Certificates.Field]? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        return APIEndpoint(
            path: "certificates/\(id)",
            method: .get,
            parameters: parameters)
    }
}
