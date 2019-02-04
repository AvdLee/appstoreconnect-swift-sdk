//
//  APIProvider.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Antoine van der Lee on 05/11/2018.
//

import Foundation


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
/// APIProviderProtocol Implementation based on URLSession
public final class APIProvider: APIProviderProtocol {

    typealias StatusCode = Int

    enum Error: Swift.Error {
        case requestGeneration
        case unknownResponseType
        case requestFailure(StatusCode)
        case decodingError
        case urlSessionError(Swift.Error)
    }
    
    /// The session manager which is used to perform network requests with.
    private let urlSession: URLSession
    
    /// Contains a JSON Decoder which can be reused.
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    /// The configuration needed to set up the API Provider including all needed information for performing API requests.
    private let configuration: APIConfiguration
    
    /// The authenticator to handle all JWT signing related actions.
    private lazy var requestsAuthenticator = JWTRequestsAuthenticator(apiConfiguration: self.configuration)
    
    /// Creates a new APIProvider instance which can be used to perform API Requests to the App Store Connect API.
    ///
    /// - Parameters:
    ///   - configuration: The configuration needed to set up the API Provider including all needed information for performing API requests.
    public init(configuration: APIConfiguration) {
        self.configuration = configuration
        self.urlSession = URLSession(configuration: .default)
    }
        
    /// Performs a data request to the given API endpoint
    ///
    /// - Parameters:
    ///   - endpoint: The API endpoint to request.
    ///   - completion: The completion callback which will be called on completion containing the result.
    public func request(_ endpoint: APIEndpoint<Void>, completion: @escaping RequestCompletionHandler<Void>) {
        guard let request = try? self.requestsAuthenticator.adapt(endpoint.asURLRequest()) else {
            completion(.failure(Error.requestGeneration))
            return
        }

        self.urlSession.dataTask(with: request) { data, response, error in
            completion(self.mapVoidResponse(data: data, response: response, error: error))
        }.resume()
    }
    
    /// Performs a data request to the given API endpoint
    ///
    /// - Parameters:
    ///   - endpoint: The API endpoint to request.
    ///   - completion: The completion callback which will be called on completion containing the result.
    public func request<T: Decodable>(_ endpoint: APIEndpoint<T>, completion: @escaping RequestCompletionHandler<T>) {
        guard let request = try? self.requestsAuthenticator.adapt(endpoint.asURLRequest()) else {
            completion(.failure(Error.requestGeneration))
            return
        }

        self.urlSession.dataTask(with: request) { data, response, error in
            completion(self.mapResponse(data: data, response: response, error: error))
        }.resume()
    }
    
    /// Performs a data request to the given ResourceLinks
    ///
    /// - Parameters:
    ///   - resourceLinks: The resourceLinks to request.
    ///   - completion: The completion callback which will be called on completion containing the result.
    public func request<T: Decodable>(_ resourceLinks: ResourceLinks<T>, completion: @escaping RequestCompletionHandler<T>) {

        self.urlSession.dataTask(with: resourceLinks.`self`) { data, response, error in
            completion(self.mapResponse(data: data, response: response, error: error))
        }.resume()
    }
}

// MARK: - Private

private extension APIProvider {

    func mapResponse<T: Decodable>(data: Data?, response: URLResponse?, error: Swift.Error?) -> Result<T> {
        if let error = error {
            return .failure(Error.urlSessionError(error))
        }

        guard let urlResponse = response as? HTTPURLResponse else {
            return .failure(Error.unknownResponseType)
        }

        guard let data = data else {
            return .failure(Error.requestFailure(urlResponse.statusCode))
        }

        guard let decodedValue =  try? self.jsonDecoder.decode(T.self, from: data) else {
            return .failure(Error.decodingError)
        }

        return .success(decodedValue)
    }

    func mapVoidResponse(data: Data?, response: URLResponse?, error: Swift.Error?) -> Result<Void> {
        if let error = error {
            return .failure(error)
        }

        return .success(())
    }
}


