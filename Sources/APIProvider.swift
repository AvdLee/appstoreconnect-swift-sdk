//
//  APIProvider.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Antoine van der Lee on 05/11/2018.
//

import Foundation
import Alamofire

public typealias RequestCompletionHandler<T> = (Result<T>) -> Void

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

    /// The session manager which is used to perform network requests with.
    private let defaultSessionManager: SessionManager

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
    ///   - protocolClasses: Optional protocal classes to use for mocking with unit tests.
    public init(configuration: APIConfiguration, protocolClasses: [AnyClass]? = nil) {
        self.configuration = configuration

        if let protocolClasses = protocolClasses {
            let configuration = URLSessionConfiguration.default
            configuration.protocolClasses = protocolClasses + (configuration.protocolClasses ?? [])
            defaultSessionManager = SessionManager(configuration: configuration)
        } else {
            defaultSessionManager = SessionManager(configuration: URLSessionConfiguration.default)
        }

        defaultSessionManager.adapter = requestsAuthenticator
    }
    
    /// Performs a data request.
    ///
    /// - Parameters:
    ///   - request: The DataRequest to perform.
    ///   - completion: The completion callback which will be called on completion containing the result.
    internal func perform(_ request: DataRequest, completion: @escaping RequestCompletionHandler<Void>) {
        request.validate(statusCode: 200..<300)
            .response(queue: DispatchQueue.global(qos: .background), completionHandler: {
                if let error = $0.error {
                    completion(Result.failure(error))
                } else {
                    completion(Result.success(()))
                }
            })
            .resume()
    }
    
    /// Performs a data request to the given Endpoint
    ///
    /// - Parameters:
    ///   - endpoint: The Endpoint to request.
    ///   - completion: The completion callback which will be called on completion containing the result.
    @discardableResult
    public func request(_ endpoint: Endpoint<Void>, completion: @escaping RequestCompletionHandler<Void>) -> DataRequest {
        let dataRequest = defaultSessionManager.request("https://api.appstoreconnect.apple.com/v1/\(endpoint.path)", method: endpoint.method, parameters: endpoint.parameters)
        perform(dataRequest, completion: completion)
        return dataRequest
    }
    
    /// Performs a data request.
    ///
    /// - Parameters:
    ///   - request: The DataRequest to perform.
    ///   - completion: The completion callback which will be called on completion containing the result.
    internal func perform<T: Decodable>(_ request: DataRequest, completion: @escaping RequestCompletionHandler<T>) {
        request.validate(statusCode: 200..<300)
            .mapResponseTo(T.self, decoder: jsonDecoder, completion: completion)
            .resume()
    }
    
    /// Performs a data request to the given Endpoint
    ///
    /// - Parameters:
    ///   - endpoint: The Endpoint to request.
    ///   - completion: The completion callback which will be called on completion containing the result.
    @discardableResult
    public func request<T: Decodable>(_ endpoint: Endpoint<T>, completion: @escaping RequestCompletionHandler<T>) -> DataRequest {
        let dataRequest = defaultSessionManager.request("https://api.appstoreconnect.apple.com/v1/\(endpoint.path)", method: endpoint.method, parameters: endpoint.parameters)
        perform(dataRequest, completion: completion)
        return dataRequest
    }
    
    /// Performs a data request to the given ResourceLinks
    ///
    /// - Parameters:
    ///   - resourceLinks: The resourceLinks to request.
    ///   - completion: The completion callback which will be called on completion containing the result.
    @discardableResult
    public func request<T: Decodable>(resourceLinks: ResourceLinks<T>, completion: @escaping RequestCompletionHandler<T>) -> DataRequest {
        let dataRequest = defaultSessionManager.request(resourceLinks.`self`)
        perform(dataRequest, completion: completion)
        return dataRequest
    }
}

extension DataRequest {

    /// Defines errors which are caused on JSON mapping.
    enum JSONMappingError: Error {
        /// Indicates that the response is not a valid JSON dictionary.
        case invalidResponse
    }

    /// Maps the response to the given JSONDecodable data type.
    ///
    /// - Parameters:
    ///   - type: The type to map to.
    ///   - completion: The result of the mapping. An error will be returned if mapping fails.
    @discardableResult
    func mapResponseTo<T: Decodable>(_ type: T.Type, decoder: JSONDecoder, completion: @escaping RequestCompletionHandler<T>) -> Self {
        return responseData(queue: DispatchQueue.global(qos: .background)) { (response) in
            if let error = response.error {
                // Try to parse api error
                guard let data = response.data, let apiError = try? decoder.decode(ErrorResponse.self, from: data) else {
                    completion(Result.failure(error))
                    return
                }
                completion(Result.failure(apiError))
            } else {
                // Try to parse the model
                do {
                    guard let data = response.data else {
                        throw JSONMappingError.invalidResponse
                    }
                    
                    // print(try JSONSerialization.jsonObject(with: data, options: []))

                    let codable = try decoder.decode(T.self, from: data)
                    completion(Result.success(codable))
                } catch {
                    completion(Result.failure(error))
                }
            }
        }
    }
}
