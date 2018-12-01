//
//  ModifyBetaBuildLocalization.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

import Foundation
import Alamofire

extension APIEndpoint where T == BetaBuildLocalizationResponse {

    /// Update the localized What’s New text for a specific beta build and locale.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - whatsNew: A field that describes changes and additions to a build and indicates features you would like your users to test.
    public static func modify(
        betaBuildLocalizationWithId id: String,
        whatsNew: String? = nil) -> APIEndpoint {
        let request = BetaBuildLocalizationUpdateRequest(id: id, whatsNew: whatsNew)
        return APIEndpoint(
            path: "betaBuildLocalizations/\(id)",
            method: .patch,
            parameters: nil,
            body: try? JSONEncoder().encode(request))
    }
}
