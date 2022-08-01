//
//  GetPerfPowerMetrics.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Huy Vo on 1/8/22.
//

import Foundation

extension APIEndpoint where T == XcodeMetrics {

    /// Get all file sizes for a specific build bundle.
    ///
    /// - Parameters:
    ///   - id: An opaque resource ID that uniquely identifies the resource.
    public static func perfPowerMetrics(
        withAppResourceId id: String) -> APIEndpoint {
        return APIEndpoint(path: "apps/\(id)/perfPowerMetrics", method: .get)
    }
}
