//
//  URLSessionRequestExecutor.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Michael Schwarz on 04.02.19.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

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
    public func execute(_ urlRequest: URLRequest, completion: @escaping (Result<Response<Data>, Swift.Error>) -> Void) {
        urlSession.dataTask(with: urlRequest) { data, response, error in
            completion(mapResponse(data: data, urlResponse: response, error: error))
        }.resume()
    }

    /// Download report as file
    ///
    /// - Parameters:
    ///   - urlRequest: The URLRequest to execute
    ///   - completion: A result type containing eiter the response or an error
    public func download(_ urlRequest: URLRequest, completion: @escaping (Result<Response<URL>, Swift.Error>) -> Void) {
        urlSession.downloadTask(with: urlRequest) { fileUrl, response, error in
            completion(mapResponse(fileUrl: fileUrl, urlResponse: response, error: error))
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
func mapResponse(data: Data?, urlResponse: URLResponse?, error: Error?) -> Result<Response<Data>, Swift.Error> {
    if let error = error {
        return .failure(error)
    } else {
        guard let httpUrlResponse = urlResponse as? HTTPURLResponse else {
            return .failure(DefaultRequestExecutor.Error.unknownResponseType)
        }

        return .success(.init(requestURL: httpUrlResponse.url, statusCode: httpUrlResponse.statusCode, data: data))
    }
}

/// Maps the result of an URLSession downloadTask to a response type
///
/// - Parameters:
///   - fileUrl: The file URL of the arquive containing the data returned from an URLSession download  task
///   - urlResponse: URLResponse returned from an URLSession data task
///   - error: Error returned from an URLSession data task
///   - completion: A result type containing eiter the response or an error
func mapResponse(fileUrl: URL?, urlResponse: URLResponse?, error: Error?) -> Result<Response<URL>, Swift.Error> {
    if let error = error {
        return .failure(error)
    } else {
        guard let httpUrlResponse = urlResponse as? HTTPURLResponse else {
            return .failure(DefaultRequestExecutor.Error.unknownResponseType)
        }

        return .success(.init(requestURL: httpUrlResponse.url, statusCode: httpUrlResponse.statusCode, data: fileUrl))
    }
}
