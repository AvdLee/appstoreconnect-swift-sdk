//
//  Parameters.swift
//  Alamofire
//
//  Created by Pascal Edmond on 20/11/2018.
//

import Foundation

// Represents a query parameter.
// AppStoreConnect API accepts parameters like `limit` and "nested" ones
// like`limit[apps]` to coexist at the same time.
protocol NestableQueryParameter {
    typealias Pair = (nestedKey: String?, value: String)
    static var key: String { get }
    var pair: Pair { get }
}

// MARK: - Helpers
// AppStoreConnect API does not allow to encode Arrays by specifying several
// times the same key like these:
//   - `?key=value1&key=value1`
//   - `?key[]=value1&key[]=value1`
//
// These extensions are helping encoding arrays the way AppStoreConnect API want
// `?key=value,value1`
extension Array where Element == String {
    func joinedByCommas() -> String {
        return joined(separator: ",")
    }
}

extension Dictionary where Key == String, Value == Any {

    mutating func add<T: NestableQueryParameter>(_ parameters: [T]) {
        return merge(encodedDictionary(parameters), uniquingKeysWith: { $1 })
    }

    private func encodedDictionary<T: NestableQueryParameter>(_ parameters: [T]) -> [String: Any] {
        var dict = [String: Any]()
        for parameter in parameters {
            switch parameter.pair {
            case (let nestedKey?, let value):
                let key = "\(T.key)[\(nestedKey)]"
                if let existingValue = dict[key] as? String {
                    dict[key] = [existingValue, value].joinedByCommas()
                } else {
                    dict[key] = value
                }
            case (_, let value):
                if let existingValue = dict[T.key] as? String {
                    dict[T.key] = [existingValue, value].joinedByCommas()
                } else {
                    dict[T.key] = value
                }
            }
        }
        return dict
    }
}
