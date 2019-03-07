//
//  URLSessionRequestExecutor.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Michael Schwarz on 04.02.19.
//

import Foundation

/// An URLSession based RequestExecutor implemention
public final class DefaultRequestExecutor: RequestExecutor {

    enum Error: Swift.Error {
        // if the response is no HTTPURLResponse
        case unknownResponseType
    }

    private let urlSession = URLSession(configuration: .default)

    public init() { }

    // MARK: - RequestExecutor

    /// Executes an URLRequest and delivers an async result
    ///
    /// - Parameters:
    ///   - urlRequest: The URLRequest to execute
    ///   - completion: A result type containing eiter the response or an error
    public func execute(_ urlRequest: URLRequest, completion: @escaping (Result<Response>) -> Void) {
        urlSession.dataTask(with: urlRequest) { data, response, error in
            completion(mapResponse(data: data, urlResponse: response, error: error))
        }.resume()
    }

    /// Retrieves a resource and delivers an async result
    ///
    /// - Parameters:
    ///   - url: The URL where the resource is located
    ///   - completion: A result type containing eiter the response or an error
    public func retrieve(_ url: URL, completion: @escaping (Result<Response>) -> Void) {
        urlSession.dataTask(with: url) { data, response, error in
            completion(mapResponse(data: data, urlResponse: response, error: error))
        }.resume()
    }
}

// MARK: - Private

/// Maps the result of an URLSession dataTask to a response type
///
/// - Parameters:
///   - data: Data returned from an URLSession data task
///   - urlResponse: URLResponse returned from an URLSession data task
///   - error: Error returned from an URLSession data task
///   - completion: A result type containing eiter the response or an error
func mapResponse(data: Data?, urlResponse: URLResponse?, error: Error?) -> Result<Response> {
    if let error = error {
        return .failure(error)
    } else {
        guard let httpUrlResponse = urlResponse as? HTTPURLResponse else {
            return .failure(DefaultRequestExecutor.Error.unknownResponseType)
        }

        return .success(.init(statusCode: httpUrlResponse.statusCode, data: data))
    }
}
