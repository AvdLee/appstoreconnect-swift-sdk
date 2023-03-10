//
//  Endpoints.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Antoine van der Lee on 05/11/2018.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

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
public struct Request<Response> {
    public var method: String
    public var path: String
    public var query: [(String, String?)]?
    var body: AnyEncodable?
    public var headers: [String: String]?
    public var id: String?

    public init(method: String, path: String, query: [(String, String?)]? = nil, headers: [String: String]? = nil) {
        self.method = method
        self.path = path
        self.query = query
        self.headers = headers
    }

    public init<U: Encodable>(method: String, path: String, query: [(String, String?)]? = nil, body: U?, headers: [String: String]? = nil) {
        self.method = method
        self.path = path
        self.query = query
        self.body = body.map(AnyEncodable.init)
        self.headers = headers
    }

    public static func get(_ path: String, query: [(String, String?)]? = nil, headers: [String: String]? = nil) -> Request {
        Request(method: "GET", path: path, query: query, headers: headers)
    }

    public static func post(_ path: String, query: [(String, String?)]? = nil, headers: [String: String]? = nil) -> Request {
        Request(method: "POST", path: path, query: query, headers: headers)
    }

    public static func post<U: Encodable>(_ path: String, query: [(String, String?)]? = nil, body: U?, headers: [String: String]? = nil) -> Request {
        Request(method: "POST", path: path, query: query, body: body, headers: headers)
    }

    public static func put(_ path: String, query: [(String, String?)]? = nil, headers: [String: String]? = nil) -> Request {
        Request(method: "PUT", path: path, query: query, headers: headers)
    }

    public static func put<U: Encodable>(_ path: String, query: [(String, String?)]? = nil, body: U?, headers: [String: String]? = nil) -> Request {
        Request(method: "PUT", path: path, query: query, body: body, headers: headers)
    }

    public static func patch(_ path: String, query: [(String, String?)]? = nil, headers: [String: String]? = nil) -> Request {
        Request(method: "PATCH", path: path, query: query, headers: headers)
    }

    public static func patch<U: Encodable>(_ path: String, query: [(String, String?)]? = nil, body: U?, headers: [String: String]? = nil) -> Request {
        Request(method: "PATCH", path: path, query: query, body: body, headers: headers)
    }

    public static func delete(_ path: String, query: [(String, String?)]? = nil, headers: [String: String]? = nil) -> Request {
        Request(method: "DELETE", path: path, query: query, headers: headers)
    }

    public static func delete<U: Encodable>(_ path: String, query: [(String, String?)]? = nil, body: U?, headers: [String: String]? = nil) -> Request {
        Request(method: "DELETE", path: path, query: query, body: body, headers: headers)
    }

    public static func options(_ path: String, query: [(String, String?)]? = nil, headers: [String: String]? = nil) -> Request {
        Request(method: "OPTIONS", path: path, query: query, headers: headers)
    }

    public static func head(_ path: String, query: [(String, String?)]? = nil, headers: [String: String]? = nil) -> Request {
        Request(method: "HEAD", path: path, query: query, headers: headers)
    }

    public static func trace(_ path: String, query: [(String, String?)]? = nil, headers: [String: String]? = nil) -> Request {
        Request(method: "TRACE", path: path, query: query, headers: headers)
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
        let url = try makeURL(path: path, query: query)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method

        if let body = body {
            urlRequest.httpBody = try encoder.encode(body)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        return urlRequest
    }
}
