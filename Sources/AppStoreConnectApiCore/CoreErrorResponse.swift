//
//  CoreErrorResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Yusuf Özgül on 17.09.2025.
//

public protocol ErrorResponseInterface: CustomStringConvertible {
    associatedtype ErrorType: ErrorResponseErrorItemInterface
    var errors: [ErrorType]? { get }
}

public protocol ErrorResponseErrorItemInterface {
    var status: String { get }
    var code: String { get }
    var title: String { get }
    var detail: String { get }
}

public struct CoreErrorResponse: Codable, ErrorResponseInterface {
    public var errors: [ErrorItem]?
    public var description: String {
        var errorString = "Related response error(s):"
        errors?.forEach({ error in
            errorString.append("""
        \n\nThe request failed with response code \(error.status) \(error.code)

        \(error.title). \(error.detail)
        """)
        })
        return errorString
    }

    public struct ErrorItem: Codable, ErrorResponseErrorItemInterface {
        public var status: String
        public var code: String
        public var title: String
        public var detail: String
    }
}
