//
//  APIProviderProtocol.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Michael Schwarz on 23.01.19.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// The result type delivered from a successful URLRequest
public struct Response<T> {
    public typealias StatusCode = Int

    public let requestURL: URL?
    public let statusCode: Int
    public let data: T?
    public let errorResponse: ErrorResponse?
    public let rateLimit: RateLimit?

    public init(requestURL: URL?, statusCode: StatusCode, allHeaderFields: [AnyHashable: Any], data: T?) {
        self.requestURL = requestURL
        self.statusCode = statusCode
        self.data = data

        if let data = data as? Data {
            self.errorResponse = try? APIProvider.jsonDecoder.decode(ErrorResponse.self, from: data)
        } else {
            self.errorResponse = nil
        }
        
        if let rateLimitValue = allHeaderFields["X-Rate-Limit"] as? String {
            self.rateLimit = RateLimit(value: rateLimitValue, requestURL: requestURL)
        } else {
            self.rateLimit = nil
        }
    }
}

/// Protocol abstraction which contains all necessary methods for URLRequest execution
public protocol RequestExecutor {

    /// Performs a URLRequest and returns a result
    func execute(_ urlRequest: URLRequest, completion: @escaping (Result<Response<Data>, Swift.Error>) -> Void)

    /// Download report as file a given URL
    func download(_ urlRequest: URLRequest, completion: @escaping (Result<Response<URL>, Swift.Error>) -> Void)

}
