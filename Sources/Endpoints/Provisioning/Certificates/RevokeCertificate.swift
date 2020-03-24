//
//  RevokeCertificate.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/15/19.
//

extension APIEndpoint where Request == EmptyBody, Response == IrrelevantResponse {

    /// Revoke a lost, stolen, compromised, or expiring signing certificate.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the certificate.
    public static func revokeCertificate(withId id: String) -> APIEndpoint {
        return APIEndpoint(
            path: "certificates/\(id)",
            method: .delete,
            parameters: nil)
    }
}
