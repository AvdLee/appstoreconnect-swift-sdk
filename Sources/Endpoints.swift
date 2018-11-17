//
//  Endpoints.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Antoine van der Lee on 05/11/2018.
//

import Foundation
import Alamofire

/// Defines all data needed to build the URL Request with.
public struct APIEndpoint<T: Decodable> {

    /// The path to the endpoint.
    let path: String

    /// The HTTP Method to use for the request.
    let method: Alamofire.HTTPMethod

    /// The JSON type model to map the response to.
    let responseType: T.Type = T.self

    /// The parameters to send with the request. Can be `nil`.
    let parameters: [String: Any]?

    init(path: String, method: Alamofire.HTTPMethod = .get, parameters: [String: Any]? = nil) {
        self.path = path
        self.method = method
        self.parameters = parameters
    }
}

/// Contains all API endpoints to the App Store Connect API
extension APIEndpoint {

    /// Find and list apps added in App Store Connect.
    public static func apps() -> APIEndpoint<AppsResponse> {
        return APIEndpoint<AppsResponse>(path: "apps")
    }

}
