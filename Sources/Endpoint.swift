//
//  Endpoints.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Antoine van der Lee on 05/11/2018.
//

import Foundation

struct AnyEncodable: Encodable {
    private let value: Encodable

    init(_ value: Encodable) {
        self.value = value
    }

    func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}

/// Credits to the https://github.com/kean/Get repository for this class.
/// We've copied this over since it works nicely together with the CreateAPI OpenAPI generator.
public struct Request<Response>: @unchecked Sendable {
    public var method: String
    public var url: String
    public var query: [(String, String?)]?
    public let body: Encodable?
    public var headers: [String: String]?
    public var id: String?

    public init(
        method: String = "GET",
        url: String,
        query: [(String, String?)]? = nil,
        body: Encodable? = nil,
        headers: [String: String]? = nil,
        id: String? = nil
    ) {
        self.method = method
        self.url = url
        self.query = query
        self.headers = headers
        self.body = body
        self.id = id
    }
}

// MARK: - URLRequestConvertible

extension Request {

    internal var baseURL: URL {
        // swiftlint:disable:next force_unwrapping
        return URL(string: "https://api.appstoreconnect.apple.com")!
    }

    private func makeURL(path: String, query: [(String, String?)]?) throws -> URL {
        let url = baseURL.appendingPathComponent(path)
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }
        if let query = query, !query.isEmpty {
            components.queryItems = query.map(URLQueryItem.init)
        }
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        return url
    }

    /// Generates a request based on the current endpoint.
    public func asURLRequest(encoder: JSONEncoder) throws -> URLRequest {
        let url = try makeURL(path: url, query: query)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method

        if let body = body {
            urlRequest.httpBody = try encoder.encode(AnyEncodable(body))
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        return urlRequest
    }
}
