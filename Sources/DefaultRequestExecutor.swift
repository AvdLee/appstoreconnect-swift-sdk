//
//  URLSessionRequestExecutor.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Michael Schwarz on 04.02.19.
//

import Foundation


// A URLSession based RequestExecutor
public final class DefaultRequestExecutor: RequestExecutor {

    enum Error: Swift.Error {
        case unknownResponseType
    }

    private let urlSession = URLSession(configuration: .ephemeral)

    public init() { }

    // MARK: - RequestExecutor

    public func execute(_ urlRequest: URLRequest, completion: @escaping (Result<Response>) -> Void) {
        self.urlSession.dataTask(with: urlRequest) { data, response, error in
            completion(mapResponse(data: data, urlResponse: response, error: error))
        }.resume()
    }

    public func retrieve(_ url: URL, completion: @escaping (Result<Response>) -> Void) {
        self.urlSession.dataTask(with: url) { data, response, error in
            completion(mapResponse(data: data, urlResponse: response, error: error))
        }.resume()
    }
}

// MARK: - Private

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
