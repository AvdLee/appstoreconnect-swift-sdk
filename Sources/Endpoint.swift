//
//  Endpoints.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Antoine van der Lee on 05/11/2018.
//

import Foundation


/// Defines all data needed to build the URL Request with.
public struct APIEndpoint<T> {

    /// The path to the endpoint.
    let path: String

    /// The HTTP Method to use for the request.
    let method: HTTPMethod

    /// The parameters to send with the request. Can be `nil`.
    let parameters: [String: Any]?
    
    /// The body to send with the request. Can be `nil`.
    let body: Data?
    
    init(path: String, method: HTTPMethod = .get, parameters: [String: Any]? = nil, body: Data? = nil) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.body = body
    }
}

// MARK: - URLRequestConvertible

extension APIEndpoint {
    
    /// Generates an URL based on the current endpoint in combination with the current API version.
    internal var url: URL {
        // swiftlint:disable:next force_unwrapping
        return URL(string: "https://api.appstoreconnect.apple.com/v1/")!.appendingPathComponent(path)
    }
    
    /// Generates a request based on the current endpoint.
    public func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: self.url)
        urlRequest.httpMethod = self.method.rawValue
        urlRequest.encodeParameters(self.parameters)

        if let body = self.body {
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            urlRequest.httpBody = body
        }
        return urlRequest
    }
}

// MARK: - Private

private extension URLRequest {

    mutating func encodeParameters(_ parameters: [String: Any]?) {
        guard let parameters = parameters, parameters.isEmpty == false else { return }
        guard let url = self.url else { return }

        func encode(_ value: Any) -> String {
            func percentEncode(_ string: String) -> String {
                return string.addingPercentEncoding(withAllowedCharacters: .afURLQueryAllowed) ?? string
            }
            switch value {
            case let intValue as Int:
                return percentEncode(String(intValue))
            case let stringValue as String:
                return percentEncode(stringValue)
            default:
                fatalError("Could not encode \(value)")
            }
        }

        func query(_ parameters: [String: Any]) -> String {
            return parameters.sorted { $0.key < $1.key }.map { "\(encode($0))=\(encode($1))" }.joined(separator: "&")
        }

        if self.httpMethod == HTTPMethod.get.rawValue {
            let newQueryToAppend = query(parameters)
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            let existingQuery = urlComponents?.percentEncodedQuery.map { $0 + "&" } ?? ""
            urlComponents?.percentEncodedQuery = existingQuery + newQueryToAppend
            self.url = urlComponents?.url
        } else {
            if self.value(forHTTPHeaderField: "Content-Type") == nil {
                self.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            }

            self.httpBody = query(parameters).data(using: .utf8, allowLossyConversion: false)
        }

    }
}

// Extracted from Alamofire
fileprivate extension CharacterSet {
    /// Creates a CharacterSet from RFC 3986 allowed characters.
    ///
    /// RFC 3986 states that the following characters are "reserved" characters.
    ///
    /// - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
    /// - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
    ///
    /// In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
    /// query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
    /// should be percent-escaped in the query string.
    fileprivate static let afURLQueryAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        let encodableDelimiters = CharacterSet(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")

        return CharacterSet.urlQueryAllowed.subtracting(encodableDelimiters)
    }()
}

