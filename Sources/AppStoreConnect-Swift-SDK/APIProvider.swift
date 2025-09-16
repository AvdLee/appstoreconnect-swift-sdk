//
//  APIProvider.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Antoine van der Lee on 05/11/2018.
//

import Foundation
#if os(Linux)
import OpenCombine
#else
import Combine
#endif
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public typealias RequestCompletionHandler<T> = (Result<T, Swift.Error>) -> Void

/// The configuration needed to set up the API Provider including all needed information for performing API requests.
public struct APIConfiguration {

    /// Your private key ID from App Store Connect (Ex: 2X9R4HXF34)
    let privateKeyID: String

    /// Your private key from App Store Connect
    let privateKey: JWT.PrivateKey

    /// Your issuer ID from the API Keys page in App Store Connect (Ex: 57246542-96fe-1a63-e053-0824d011072a)
    let issuerID: String?

    /// The token's expiration duration in seconds. Tokens that expire more than 20 minutes in the future are not valid, so set it to a max of 20 minutes.
    let expirationDuration: TimeInterval

    /// The range of values allowed for the expiration duration of the token.
    private let allowedExpirationDurationRange: ClosedRange<TimeInterval> = 0...1200

    /// Creates a new API configuration to use for initialising the API Provider.
    ///
    /// - Parameters:
    ///   - issuerID: Your issuer ID from the API Keys page in App Store Connect (Ex: 57246542-96fe-1a63-e053-0824d011072a)
    ///   - privateKeyID: Your private key ID from App Store Connect (Ex: 2X9R4HXF34)
    ///   - privateKey: Your private key stripped out of the -----BEGIN PRIVATE KEY----- and -----END PRIVATE KEY----- lines.
    ///   - expirationDuration: The token's expiration duration in seconds. Tokens that expire more than 20 minutes in the future are not valid, so set it to a max of 20 minutes. Defaults to 20 minutes.
    public init(issuerID: String, privateKeyID: String, privateKey: String, expirationDuration: TimeInterval = 60 * 20) throws {
        self.privateKeyID = privateKeyID
        self.issuerID = issuerID
        guard let base64Key = Data(base64Encoded: privateKey) else {
            throw JWT.Error.invalidBase64EncodedPrivateKey
        }
        do {
            self.privateKey = try JWT.PrivateKey(derRepresentation: base64Key)
        } catch {
            throw JWT.Error.invalidPrivateKey
        }
        guard allowedExpirationDurationRange ~= expirationDuration else {
            throw JWT.Error.invalidExpirationDuration
        }
        self.expirationDuration = expirationDuration
    }
    
    /// Creates a new API configuration to use for initialising the API Provider.
    ///
    /// - Parameters:
    ///   - individualPrivateKeyID: Your private key ID from App Store Connect (Ex: 2X9R4HXF34)
    ///   - individualPrivateKey: The contents of the individual private key from App Store Connect
    ///   - expirationDuration: The token's expiration duration in seconds. Tokens that expire more than 20 minutes in the future are not valid, so set it to a max of 20 minutes. Defaults to 20 minutes.
    public init(individualPrivateKeyID: String, individualPrivateKey: String, expirationDuration: TimeInterval = 60 * 20) throws {
        self.privateKeyID = individualPrivateKeyID
        self.issuerID = nil

        guard let base64Key = Data(base64Encoded: individualPrivateKey) else {
            throw JWT.Error.invalidBase64EncodedPrivateKey
        }
        do {
            self.privateKey = try JWT.PrivateKey(derRepresentation: base64Key)
        } catch {
            throw JWT.Error.invalidPrivateKey
        }
        guard allowedExpirationDurationRange ~= expirationDuration else {
            throw JWT.Error.invalidExpirationDuration
        }
        self.expirationDuration = expirationDuration
    }
    
    /// Creates a new API configuration to use for initialising the API Provider.
    ///
    /// - Parameters:
    ///   - issuerID: Your issuer ID from the API Keys page in App Store Connect (Ex: 57246542-96fe-1a63-e053-0824d011072a)
    ///   - privateKeyID: Your private key ID from App Store Connect (Ex: 2X9R4HXF34). Will be inferred from `privateKeyURL` if nil.
    ///   - privateKeyURL: A file URL that references the path to your private key file.
    ///   - expirationDuration: The token's expiration duration in seconds. Tokens that expire more than 20 minutes in the future are not valid, so set it to a max of 20 minutes. Defaults to 20 minutes.
    public init(issuerID: String, privateKeyID: String? = nil, privateKeyURL: URL, expirationDuration: TimeInterval = 60 * 20) throws {
        self.issuerID = issuerID
        if let privateKeyID = privateKeyID {
            self.privateKeyID = privateKeyID
        } else {
            let filename = privateKeyURL.deletingPathExtension().lastPathComponent
            self.privateKeyID = String(filename.suffix(10))
        }
        do {
            let pemEncodedPrivateKey = try String(contentsOf: privateKeyURL)
            self.privateKey = try JWT.PrivateKey(pemRepresentation: pemEncodedPrivateKey)
        } catch {
            throw JWT.Error.invalidPrivateKey
        }
        guard allowedExpirationDurationRange ~= expirationDuration else {
            throw JWT.Error.invalidExpirationDuration
        }
        self.expirationDuration = expirationDuration
    }
    
    /// Creates a new API configuration to use for initialising the API Provider.
    ///
    /// - Parameters:
    ///   - individualPrivateKeyID: Your private key ID from App Store Connect (Ex: 2X9R4HXF34). Will be inferred from `privateKeyURL` if nil.
    ///   - individualPrivateKeyURL: A file URL that references the path to your private key file.
    ///   - expirationDuration: The token's expiration duration in seconds. Tokens that expire more than 20 minutes in the future are not valid, so set it to a max of 20 minutes. Defaults to 20 minutes.
    public init(individualPrivateKeyID: String? = nil, privateKeyURL: URL, expirationDuration: TimeInterval = 60 * 20) throws {
        self.issuerID = nil
        if let individualPrivateKeyID {
            self.privateKeyID = individualPrivateKeyID
        } else {
            let filename = privateKeyURL.deletingPathExtension().lastPathComponent
            self.privateKeyID = String(filename.suffix(10))
        }
        do {
            let pemEncodedPrivateKey = try String(contentsOf: privateKeyURL)
            self.privateKey = try JWT.PrivateKey(pemRepresentation: pemEncodedPrivateKey)
        } catch {
            throw JWT.Error.invalidPrivateKey
        }
        guard allowedExpirationDurationRange ~= expirationDuration else {
            throw JWT.Error.invalidExpirationDuration
        }
        self.expirationDuration = expirationDuration
    }
}

/// Provides access to all API Methods. Can be used to perform API requests.
public final class APIProvider {

    public enum Error: Swift.Error, CustomDebugStringConvertible, LocalizedError {
        case requestGeneration
        case unknownResponseType
        case requestFailure(StatusCode, ErrorResponse?, URL?)
        case decodingError(Swift.Error, Data)
        case downloadError
        case dateDecodingError(String)
        case requestExecutorError(Swift.Error)

        public var errorDescription: String? {
            debugDescription
        }

        public var debugDescription: String {
            switch self {
            case .requestGeneration:
                return "Failed to generate request."
            case .unknownResponseType:
                return "Unknown response type."
            case .requestFailure(let statusCode, let errorResponse, let url):
                let url = url?.absoluteString ?? ""
                if let errorResponse = errorResponse {
                    return "Request \(url) failed with status code \(statusCode). \(errorResponse))."
                }
                return "Request \(url) failed with status code \(statusCode)."
            case .decodingError(let error, let data):
                if let response = String(data: data, encoding: .utf8) {
                    return "Failed to decode response:\n\(response)\nError: \(error)."
                }
                return "Failed to decode data."
            case .downloadError:
                return "File url not generated."
            case .dateDecodingError(let date):
                return "Failed to decode date: \(date)"
            case .requestExecutorError(let error):
                return "Failed to execute request \(error)."
            }
        }
    }

    public typealias StatusCode = Int

    /// Contains a JSON Decoder which can be reused.
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.calendar = Calendar(identifier: .iso8601)

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
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            // Example: 2024-01-01T23:59:59.000+00:00
            let isoDateFormatter = ISO8601DateFormatter()
            isoDateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            if let date = isoDateFormatter.date(from: dateStr) {
                return date
            }
            throw APIProvider.Error.dateDecodingError(dateStr)
        })
        return decoder
    }()

    /// The configuration needed to set up the API Provider including all needed information for performing API requests.
    private let configuration: APIConfiguration

    /// The authenticator to handle all JWT signing related actions.
    private let requestsAuthenticator: JWTRequestsAuthenticator

    /// Handles URLRequest execution
    private let requestExecutor: RequestExecutor

    /// The JSON encoder used to encode request parameters.
    private let encoder: JSONEncoder
    
    /// Exposes rate limit continously as requests are made.
    public let rateLimitPublisher = PassthroughSubject<RateLimit, Never>()

    /// Creates a new APIProvider instance which can be used to perform API Requests to the App Store Connect API.
    ///
    /// - Parameters:
    ///   - configuration: The configuration needed to set up the API Provider including all needed information for performing API requests.
    ///   - requestExecutor: An instance conforming to the RequestExecutor protocol for executing URLRequest
    public init(configuration: APIConfiguration, requestExecutor: RequestExecutor = DefaultRequestExecutor()) {
        self.configuration = configuration
        self.requestExecutor = requestExecutor
        self.requestsAuthenticator = JWTRequestsAuthenticator(apiConfiguration: configuration)
        self.encoder = JSONEncoder()
        self.encoder.dateEncodingStrategy = .iso8601
    }

    /// Performs a data request to the given API endpoint
    ///
    /// - Parameters:
    ///   - endpoint: The API endpoint to request.
    ///   - completion: The completion callback which will be called on completion containing the result.
    public func request(_ request: Request<Void>, completion: @escaping RequestCompletionHandler<Void>) {
        guard let request = try? requestsAuthenticator.adapt(request.asURLRequest(encoder: encoder)) else {
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
    public func request<T: Decodable>(_ request: Request<T>, completion: @escaping RequestCompletionHandler<T>) {
        guard let request = try? requestsAuthenticator.adapt(request.asURLRequest(encoder: encoder)) else {
            completion(.failure(Error.requestGeneration))
            return
        }

        requestExecutor.execute(request) { completion(self.mapResponse($0)) }
    }

    /// Performs a download request to the given API endpoint
    ///
    /// - Parameters:
    ///   - endpoint: The API endpoint to request.
    ///   - completion: The completion callback which will be called on completion containing the result.
    public func download<T: Decodable>(_ request: Request<T>, completion: @escaping RequestCompletionHandler<URL>) {
        guard let request = try? requestsAuthenticator.adapt(request.asURLRequest(encoder: encoder)) else {
            completion(.failure(Error.requestGeneration))
            return
        }

        requestExecutor.download(request) { completion(self.mapResponse($0)) }
    }
}

// MARK: - async/await
extension APIProvider {
    /// Performs a data request to the given API endpoint
    ///
    /// - Parameters:
    ///   - endpoint: The API endpoint to request.
    public func request(_ endpoint: Request<Void>) async throws {
        try await withCheckedThrowingContinuation { continuation in
            request(endpoint, completion: continuation.resume(with:))
        }
    }

    /// Performs a data request to the given API endpoint
    ///
    /// - Parameters:
    ///   - endpoint: The API endpoint to request.
    public func request<T>(_ endpoint: Request<T>) async throws -> T where T: Decodable {
        try await withCheckedThrowingContinuation { continuation in
            request(endpoint, completion: continuation.resume(with:))
        }
    }

    /// Performs a download request to the given API endpoint
    ///
    /// - Parameters:
    ///   - endpoint: The API endpoint to request.
    public func download<T>(_ endpoint: Request<T>) async throws -> URL where T: Decodable {
        try await withCheckedThrowingContinuation { continuation in
            download(endpoint, completion: continuation.resume(with:))
        }
    }
}

// MARK: - Private
private extension APIProvider {

    /// Maps a network response to a decodable type
    ///
    /// - Parameter result: A result type containing either the network response or an error
    /// - Returns: A result type containing either the decoded type or an error
    func mapResponse<T: Decodable>(_ result: Result<Response<Data>, Swift.Error>) -> Result<T, Swift.Error> {
        switch result {
        case .success(let response):
            if let rateLimit = response.rateLimit {
                rateLimitPublisher.send(rateLimit)
            }
            
            guard let data = response.data, 200..<300 ~= response.statusCode else {
                return .failure(Error.requestFailure(response.statusCode, response.errorResponse, response.requestURL))
            }

            if let data = data as? T {
                return .success(data)
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
    func mapVoidResponse(_ result: Result<Response<Data>, Swift.Error>) -> Result<Void, Swift.Error> {
        switch result {
        case .success(let response):
            if let rateLimit = response.rateLimit {
                rateLimitPublisher.send(rateLimit)
            }
            
            guard 200..<300 ~= response.statusCode else {
                return .failure(Error.requestFailure(response.statusCode, response.errorResponse, response.requestURL))
            }

            return .success(())
        case .failure(let error):
            return .failure(Error.requestExecutorError(error))
        }
    }

    /// Maps a download response to a URL type
    ///
    /// - Parameter result: A result type containing either the network response or an error
    /// - Returns: A result type containing either the decoded type or an error
    func mapResponse(_ result: Result<Response<URL>, Swift.Error>) -> Result<URL, Swift.Error> {
        switch result {
        case .success(let response):
            if let rateLimit = response.rateLimit {
                rateLimitPublisher.send(rateLimit)
            }
            
            guard 200..<300 ~= response.statusCode else {
                return .failure(Error.requestFailure(response.statusCode, response.errorResponse, response.requestURL))
            }
            if let data = response.data {
                return .success(data)
            }
            return .failure(Error.downloadError)
        case .failure(let error):
            return .failure(Error.requestExecutorError(error))
        }
    }
}

// MARK: - Paged API endpoint responses

extension APIProvider {
    
    /// Performs a data request to the given API endpoint and returns an AsyncSequence of the responses
    ///
    /// This request will allow the consumption of responses from any endpoint that can deliver responses in multiple pages
    ///
    /// - Parameter endpoint: The API endpoint to request.
    /// - Returns: An AsyncSequence of the responses from the endpoint
    public func paged<T>(_ endpoint: Request<T>) -> PagedRequest<T> {
        PagedRequest(request: endpoint, provider: self)
    }
    
    /// Performs a data request to the given API endpoint for the next page of results
    ///
    /// If the current response's paging information does not include details of a next page, ```nil``` will be returned.
    ///
    /// - Parameters:
    ///   - endpoint: endpoint: The API endpoint to request.
    ///   - pageAfter: the current response
    /// - Returns: the endpoint's next response page or nil when there is no further response
    public func request<T>(_ endpoint: Request<T>, pageAfter currentPage: T) async throws -> T? where T: Decodable {
        try await withCheckedThrowingContinuation { continuation in
            request(endpoint, pageAfter: currentPage) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    /// Is the type of response from the given API endpoint one that supports multiple pages of response?
    ///
    /// This value will be true even if there is no next page to follow on the current response.
    /// A subsequent request from the provider for the next page will respond with ```nil```
    /// immediately without wasting time communicating with the endpoint.
    ///
    /// - Parameters:
    ///   - endpoint: endpoint: The API endpoint to request.
    ///   - object: the current response
    public func request<T>(_ endpoint: Request<T>, isPagedResponse object: T) -> Bool {
        pagedDocumentLinks(object) != nil
    }
    
    private func pagedDocumentLinks<T>(_ object: T) -> PagedDocumentLinks? {
        let mirror = Mirror(reflecting: object)
        return mirror.children
                        .first(where: {
                            $0.value is PagedDocumentLinks
                        })
                        .flatMap {
                            $0.value as? PagedDocumentLinks
                        }
    }
    
    /// Performs a data request to the given API endpoint for the next page of results
    ///
    /// If the current response's paging information does not include details of a next page, ```nil``` will be returned.
    ///
    /// - Parameters:
    ///   - request: endpoint: The API endpoint to request.
    ///   - pageAfter: the current response
    ///   - completion: The completion callback which will be called on completion containing the result.
    public func request<T: Decodable>(_ request: Request<T>, pageAfter currentPage: T, completion: @escaping RequestCompletionHandler<T?>) {
                        
        guard
            let nextPage = pagedDocumentLinks(currentPage)?.next,
            let url = URL(string: nextPage)
        else {
            completion(.success(nil))
            return
        }
        
        do {
            let urlRequest = try requestsAuthenticator.adapt(URLRequest(url: url))

            requestExecutor.execute(urlRequest) { completion(self.mapResponse($0)) }
        } catch {
            completion(.failure(error))
        }
    }
}
