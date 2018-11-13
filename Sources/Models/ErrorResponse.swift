//
//  ErrorResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// Detailed error information returned in the response body whenever an API request is not successful.
public struct ErrorResponse: Decodable {

    /// An array of one or more errors.
    public let errors: [ErrorResponse.Errors]?

    /// The details about one error that is returned when an API request is not successful.
    public struct Errors: Decodable {
    
        /// (Required) A machine-readable code indicating the type of error. The code is a hierarchical value with levels of specificity separated by the '.' character. This value is parseable for programmatic error handling in code.
        public let code: String
    
        /// (Required) The HTTP status code of the error. This status code usually matches the response's status code; however, if the request produces multiple errors, these two codes may differ.
        public let status: String
    
        /// The unique ID of a specific instance of an error, request, and response. Use this ID when providing feedback to or debugging issues with Apple.
        public let `id`: String?
    
        /// (Required) A summary of the error. Do not use this field for programmatic error handling.
        public let title: String
    
        /// (Required) A detailed explanation of the error. Do not use this field for programmatic error handling.
        public let detail: String
    
        /// One of two possible types of values: source.parameter, provided when a query parameter produced the error, or source.JsonPointer, provided when a problem with the entity produced the error.￼
        ///  Possible types: ErrorResponse.Errors.JsonPointer, ErrorResponse.Errors.Parameter
        public let source: Source?
    }
}

/// MARK: ErrorResponse.Errors
extension ErrorResponse.Errors {
    /// An object containing the JSON pointer that indicates the location of the error.
    public struct JsonPointer: Decodable {
    
        /// A JSON pointer that indicates the location in the request entity where the error originates.
        public let pointer: String?
    }

    /// An object containing the query parameter that produced the error.
    public struct Parameter: Decodable {
    
        /// The query parameter that produced the error.
        public let parameter: String?
    }

    public enum Source: Decodable {
        case jsonPointer(String?)
        case parameter(String?)
        
        public init(from decoder: Decoder) throws {
            if let json = try? JsonPointer(from: decoder) {
                self = .jsonPointer(json.pointer)
            } else if let parameter = try? Parameter(from: decoder) {
                self = .parameter(parameter.parameter)
            } else {
                throw DecodingError.typeMismatch(
                    String.self,
                    DecodingError.Context(codingPath: [], debugDescription: ""))
            }
        }
    }
}
