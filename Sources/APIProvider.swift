//
//  APIProvider.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Antoine van der Lee on 05/11/2018.
//

import Foundation

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

/// An APIProvider which can be used to perform API Requests to the App Store Connect API.
public final class APIProvider {

    private let configuration: APIConfiguration

    /// Creates a new APIProvider instance which can be used to perform API Requests to the App Store Connect API.
    ///
    /// - Parameter configuration: The configuration needed to set up the API Provider including all needed information for performing API requests.
    public init(configuration: APIConfiguration) {
        self.configuration = configuration
    }
}

