//
//  APIProviderProtocol.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Michael Schwarz on 23.01.19.
//

import Foundation

/// The result type delivered from a successful URLRequest
public struct Response {
    public typealias StatusCode = Int

    public let statusCode: Int
    public let data: Data?

    public init(statusCode: StatusCode, data: Data?) {
        self.statusCode = statusCode
        self.data = data
    }
}

/// Protocol abstraction which contains all necessary methods for URLRequest execution
public protocol RequestExecutor {

    /// Performs a URLRequest and returns a result
    func execute(_ urlRequest: URLRequest, completion: @escaping (Result<Response>) -> Void)

    /// Retrieves the content of a given URL
    func retrieve(_ url: URL, completion: @escaping (Result<Response>) -> Void)
}
