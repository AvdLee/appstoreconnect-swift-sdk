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
        fatalError("Not Implemented")
    }
    
    /// Performs a data request to the given API endpoint
    ///
    /// - Parameters:
    ///   - endpoint: The API endpoint to request.
    ///   - completion: The completion callback which will be called on completion containing the result.
    public func request<T: Decodable>(_ endpoint: APIEndpoint<T>, completion: @escaping RequestCompletionHandler<T>) {
        fatalError("Not Implemented")
    }
    
    /// Performs a data request to the given ResourceLinks
    ///
    /// - Parameters:
    ///   - resourceLinks: The resourceLinks to request.
    ///   - completion: The completion callback which will be called on completion containing the result.
    public func request<T: Decodable>(_ resourceLinks: ResourceLinks<T>, completion: @escaping RequestCompletionHandler<T>) {
        fatalError("Not Implemented")
    }
}
