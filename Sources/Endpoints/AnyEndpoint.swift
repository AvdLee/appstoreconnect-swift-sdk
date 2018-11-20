//
//  AnyEndpoint.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 19/11/2018.
//

import Alamofire


public struct AnyEndpoint<T: Decodable>: Endpoint {
    public typealias Response = T
    public let path: String
    public let method: Alamofire.HTTPMethod
    public let parameters: [String: Any]?
    
    public init(path: String, method: Alamofire.HTTPMethod = .get, parameters: [String: Any]? = nil) {
        self.path = path
        self.method = method
        self.parameters = parameters
    }
}
