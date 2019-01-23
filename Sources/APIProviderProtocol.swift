//
//  APIProviderProtocol.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Michael Schwarz on 23.01.19.
//

import Foundation


public typealias RequestCompletionHandler<T> = (Result<T>) -> Void


public protocol APIProviderProtocol {

    /// Performs a data request to the given API endpoint
    ///
    /// - Parameters:
    ///   - endpoint: The API endpoint to request.
    ///   - completion: The completion callback which will be called on completion containing the result.
    func request(_ endpoint: APIEndpoint<Void>, completion: @escaping RequestCompletionHandler<Void>)


    /// Performs a data request to the given API endpoint
    ///
    /// - Parameters:
    ///   - endpoint: The API endpoint to request.
    ///   - completion: The completion callback which will be called on completion containing the result.
    func request<T: Decodable>(_ endpoint: APIEndpoint<T>, completion: @escaping RequestCompletionHandler<T>)

    /// Performs a data request to the given ResourceLinks
    ///
    /// - Parameters:
    ///   - resourceLinks: The resourceLinks to request.
    ///   - completion: The completion callback which will be called on completion containing the result.
    func request<T: Decodable>(_ resourceLinks: ResourceLinks<T>, completion: @escaping RequestCompletionHandler<T>)
}
