//
//  APIProvider.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Antoine van der Lee on 05/11/2018.
//

import Foundation

public typealias RequestCompletionHandler<T> = (Result<T, Swift.Error>) -> Void

/// The configuration needed to set up the API Provider including all needed information for performing API requests.
public struct APIConfiguration {
    
    /// Your private key ID from App Store Connect (Ex: 2X9R4HXF34)
    let privateKeyID: String
    
    let privateKey: String
    
    /// Your issuer ID from the API Keys page in App Store Connect (Ex: 57246542-96fe-1a63-e053-0824d011072a)
    let issuerID: String
    
    /// Creates a new API configuration to use for initialising the API Provider.
    ///
    /// - Parameters:
    ///   - privateKeyID: Your private key ID from App Store Connect (Ex: 2X9R4HXF34)
    ///   - issuerID: Your issuer ID from the API Keys page in App Store Connect (Ex: 57246542-96fe-1a63-e053-0824d011072a)
    public init(issuerID: String, privateKeyID: String, privateKey: String) {
        self.privateKeyID = privateKeyID
        self.privateKey = privateKey
        self.issuerID = issuerID
    }
}

/// Provides access to all API Methods. Can be used to perform API requests.
public final class APIProvider {

    public enum Error: Swift.Error, CustomDebugStringConvertible {
        case requestGeneration
        case unknownResponseType
        case requestFailure(StatusCode, Data?)
        case decodingError(Swift.Error, Data)
        case dateDecodingError(String)
        case requestExecutorError(Swift.Error)

        public var debugDescription: String {
            switch self {
            case .requestGeneration:
                return "Failed to generate request."
            case .unknownResponseType:
                return "Unknown response type."
            case .requestFailure(let statusCode, let data):
                if let data = data, let response = String(data: data, encoding: .utf8) {
                    return "Request failed with status code \(statusCode) and response \(response))."
                }
                return "Request failed with status code \(statusCode)."
            case .decodingError(let error, let data):
                if let response = String(data: data, encoding: .utf8) {
                    return "Failed to decode response:\n\(response)\nError: \(error)."
                }
                return "Failed to decode data."
            case .dateDecodingError(let date):
                return "Failed to decode date: \(date)"
            case .requestExecutorError(let error):
                return "Failed to execute request \(error)."
            }
        }
    }
    
    public typealias StatusCode = Int
    
    /// Contains a JSON Decoder which can be reused.
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)

            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            throw APIProvider.Error.dateDecodingError(dateStr)
        })
        return decoder
    }()
    
    /// The configuration needed to set up the API Provider including all needed information for performing API requests.
    private let configuration: APIConfiguration
    
    /// The authenticator to handle all JWT signing related actions.
    private lazy var requestsAuthenticator = JWTRequestsAuthenticator(apiConfiguration: self.configuration)

    /// Handles URLRequest execution
    private let requestExecutor: RequestExecutor
    
    /// Creates a new APIProvider instance which can be used to perform API Requests to the App Store Connect API.
    ///
    /// - Parameters:
    ///   - configuration: The configuration needed to set up the API Provider including all needed information for performing API requests.
    ///   - requestExecutor: An instance conforming to the RequestExecutor protocol for executing URLRequest
    public init(configuration: APIConfiguration, requestExecutor: RequestExecutor = DefaultRequestExecutor()) {
        self.configuration = configuration
        self.requestExecutor = requestExecutor
    }
        
    /// Performs a data request to the given API endpoint
    ///
    /// - Parameters:
    ///   - endpoint: The API endpoint to request.
    ///   - completion: The completion callback which will be called on completion containing the result.
    public func request(_ endpoint: APIEndpoint<Void>, completion: @escaping RequestCompletionHandler<Void>) {
        guard let request = try? requestsAuthenticator.adapt(endpoint.asURLRequest()) else {
            completion(.failure(Error.requestGeneration))
            return
        }

        requestExecutor.execute(request) { completion(self.mapVoidResponse($0)) }
    }
    
    /// Performs a data request to the given API endpoint
    ///
    /// - Parameters:
    ///   - endpoint: The API endpoint to request.
    ///   - completion: The completion callback which will be called on completion containing the result.
    public func request<T: Decodable>(_ endpoint: APIEndpoint<T>, completion: @escaping RequestCompletionHandler<T>) {
        guard let request = try? requestsAuthenticator.adapt(endpoint.asURLRequest()) else {
            completion(.failure(Error.requestGeneration))
            return
        }

        requestExecutor.execute(request) { completion(self.mapResponse($0)) }
    }
    
    /// Performs a data request to the given ResourceLinks
    ///
    /// - Parameters:
    ///   - resourceLinks: The resourceLinks to request.
    ///   - completion: The completion callback which will be called on completion containing the result.
    public func request<T: Decodable>(_ resourceLinks: ResourceLinks<T>, completion: @escaping RequestCompletionHandler<T>) {

        requestExecutor.retrieve(resourceLinks.`self`) { completion(self.mapResponse($0)) }
    }
}

// MARK: - Private

private extension APIProvider {

    /// Maps a network response to a decodable type
    ///
    /// - Parameter result: A result type containing either the network response or an error
    /// - Returns: A result type containing either the decoded type or an error
    func mapResponse<T: Decodable>(_ result: Result<Response, Swift.Error>) -> Result<T, Swift.Error> {
        switch result {
        case .success(let response):
            guard let data = response.data, 200..<300 ~= response.statusCode else {
                return .failure(Error.requestFailure(response.statusCode, response.data))
            }

            do {
                let decodedValue = try Self.jsonDecoder.decode(T.self, from: data)
                return .success(decodedValue)
            } catch {
                return .failure(Error.decodingError(error, data))
            }
        case .failure(let error):
            return .failure(Error.requestExecutorError(error))
        }
    }

    /// Maps a network response to a (void) result type
    ///
    /// - Parameter result: A result type containing either the network response or an error
    /// - Returns: A result type containing either void or an error
    func mapVoidResponse(_ result: Result<Response, Swift.Error>) -> Result<Void, Swift.Error> {
        switch result {
        case .success(let response):
            guard 200..<300 ~= response.statusCode else {
                return .failure(Error.requestFailure(response.statusCode, response.data))
            }

            return .success(())
        case .failure(let error):
            return .failure(Error.requestExecutorError(error))
        }
    }
}
