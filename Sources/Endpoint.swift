//
//  Endpoints.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Antoine van der Lee on 05/11/2018.
//

import Foundation
import Alamofire

/// Defines all data needed to build the URL Request with.
public struct APIEndpoint<T> {

    /// The path to the endpoint.
    let path: String

    /// The HTTP Method to use for the request.
    let method: Alamofire.HTTPMethod

    /// The parameters to send with the request. Can be `nil`.
    let parameters: [String: Any]?
    
    /// The body to send with the request. Can be `nil`.
    let body: Data?
    
    init(path: String, method: Alamofire.HTTPMethod = .get, parameters: [String: Any]? = nil, body: Data? = nil) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.body = body
    }
}

extension APIEndpoint: URLRequestConvertible {
    
    /// Generates an URL based on the current endpoint in combination with the current API version.
    internal var url: URL {
        // swiftlint:disable:next force_unwrapping
        return URL(string: "https://api.appstoreconnect.apple.com/v1/")!.appendingPathComponent(path)
    }
    
    /// Generates a request based on the current endpoint.
    public func asURLRequest() throws -> URLRequest {
        var urlRequest = try URLEncoding().encode(URLRequest(url: url, method: method), with: parameters)
        if let body = body {
            urlRequest.httpBody = body
        }
        return urlRequest
    }
}
