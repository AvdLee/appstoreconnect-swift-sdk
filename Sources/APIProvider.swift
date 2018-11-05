//
//  APIProvider.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Antoine van der Lee on 05/11/2018.
//

import Foundation
import Alamofire

/// The configuration needed to set up the API Provider including all needed information for performing API requests.
public struct APIConfiguration {

    /// The URL pointing to the API key file within the bundle.
    private let key: URL

    /// Creates a new API configuration to use for initialising the API Provider.
    ///
    /// - Parameter key: The API key to use for authenticating the API Requests with JWT.
    public init(key: URL) {
        self.key = key
    }
}

/// Provides access to all API Methods. Can be used to perform API requests.
public final class APIProvider {

    /// The session manager which is used to perform network requests with.
    private let defaultSessionManager: SessionManager

    /// Contains a JSON Decoder which can be reused.
    private let jsonDecoder: JSONDecoder = JSONDecoder()

    /// The configuration needed to set up the API Provider including all needed information for performing API requests.
    private let configuration: APIConfiguration

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
    }

    /// Generates an URL based on the given endpoint in combination with the current API version.
    ///
    /// - Parameter endpoint: The endpoint to create an URL for.
    /// - Returns: The created `URL`.
    internal func url<T>(for endpoint: APIEndpoint<T>) -> URL {
        return URL(string: "https://api.appstoreconnect.apple.com/v1/")!.appendingPathComponent(endpoint.path)
    }

    /// Generates a request based on the given endpoint.
    ///
    /// - Parameter endpoint: The endpoint to create a request for.
    /// - Returns: The created request.
    internal func request<T>(for endpoint: APIEndpoint<T>) -> DataRequest {
        return defaultSessionManager.request(url(for: endpoint), method: endpoint.method, parameters: endpoint.parameters)
    }

    /// Performs a data request to the given API endpoint
    ///
    /// - Parameters:
    ///   - endpoint: The API endpoint to request.
    ///   - completion: The completion callback which will be called on completion containing the result.
    @discardableResult public func request<T>(_ endpoint: APIEndpoint<T>, completion: @escaping (_ result: Result<T>) -> Void) -> DataRequest? {
        let dataRequest = request(for: endpoint)

        dataRequest.validate(statusCode: 200..<300)
            .mapResponseTo(T.self, decoder: jsonDecoder, completion: completion)
            .resume()

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
    @discardableResult func mapResponseTo<T: Decodable>(_ type: T.Type, decoder: JSONDecoder, completion: @escaping (_ result: Result<T>) -> Void) -> Self {
        return responseData(queue: DispatchQueue.global(qos: .background)) { (response) in
            if let error = response.error {
                completion(Result.failure(error))
            } else {
                // Try to parse the model
                do {
                    guard let data = response.data else {
                        throw JSONMappingError.invalidResponse
                    }

                    let codable = try decoder.decode(T.self, from: data)
                    completion(Result.success(codable))
                } catch {
                    completion(Result.failure(error))
                }
            }
        }
    }
}
