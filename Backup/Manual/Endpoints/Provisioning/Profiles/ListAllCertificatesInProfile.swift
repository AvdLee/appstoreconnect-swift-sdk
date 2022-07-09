//
//  ListAllCertificatesInProfile.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/24/19.
//

import Foundation

extension APIEndpoint where T == CertificatesResponse {

    /// Get a list of all certificates and their data for a specific provisioning profile.
    public static func listAllCertificates(
        inProfileId id: String,
        fields: [Profiles.Field]? = nil) -> APIEndpoint {

        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }

        return APIEndpoint(
            path: "profiles/\(id)/certificates",
            method: .get,
            parameters: parameters)
    }
}
