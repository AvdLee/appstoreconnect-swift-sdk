//
//  Endpoints.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Antoine van der Lee on 05/11/2018.
//

import Foundation
import Alamofire

/// Defines all data needed to build the URL Request with.
public struct Endpoint<ResponseType> {
    public let method: HTTPMethod
    public let path: String
    public let parameters: [String: Any]?
    
    public init(_ method: HTTPMethod = .get, path: String, parameters: [String: Any]? = nil) {
        self.method = method
        self.path = path
        self.parameters = parameters
    }
}
