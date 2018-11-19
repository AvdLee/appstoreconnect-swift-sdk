//
//  Endpoints.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Antoine van der Lee on 05/11/2018.
//

import Foundation
import Alamofire

/// Defines all data needed to build the URL Request with.
public protocol Endpoint {

    associatedtype Response: Decodable
    
    /// The path to the endpoint.
    var path: String { get }

    /// The HTTP Method to use for the request.
    var method: Alamofire.HTTPMethod { get }

    /// The parameters to send with the request. Can be `nil`.
    var parameters: [String: Any]? { get }
}

extension Endpoint {
    public var method: Alamofire.HTTPMethod { return .get }
}
