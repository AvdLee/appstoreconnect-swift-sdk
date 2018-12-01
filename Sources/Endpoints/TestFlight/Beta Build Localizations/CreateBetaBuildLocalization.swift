//
//  CreateBetaBuildLocalization.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

import Foundation
import Alamofire

extension APIEndpoint where T == BetaBuildLocalizationResponse {

    /// Create localized What’s New text for a build.
    ///
    /// - Parameters:
    ///   - buildId: The opaque resource ID that uniquely identifies the resource.
    ///   - locale: The specified locale. Refer to Table 1 for possible values.
    ///   - whatsNew: A field that describes changes and additions to a build and indicates features you would like your users to test.
    public static func create(
        betaBuildLocalizationForBuildWithId id: String,
        locale: String,
        whatsNew: String? = nil) -> APIEndpoint {
        let request = BetaBuildLocalizationCreateRequest(
            buildId: id,
            locale: locale,
            whatsNew: whatsNew)
        return APIEndpoint(
            path: "betaBuildLocalizations",
            method: .post,
            parameters: nil,
            body: try? JSONEncoder().encode(request))
    }
}
