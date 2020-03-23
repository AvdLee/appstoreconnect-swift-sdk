//
//  GetAllCertificateIdsInProfile.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/24/19.
//

import Foundation

extension APIEndpoint where T == ProfileCertificatesResponse {

    /// Get the resource IDs of all certificates associated with a specific provisioning profile.
    public static func getAllCertificates(
        inProfileId id: String,
        limit: Int? = nil) -> APIEndpoint {

        var parameters = [String: Any]()
        if let limit = limit { parameters["limit"] = limit }

        return APIEndpoint(
            path: "profiles/\(id)/relationships/certificates",
            method: .get,
            parameters: parameters)
    }
}
