//
//  Parameters.swift
//  Alamofire
//
//  Created by Pascal Edmond on 20/11/2018.
//

import Foundation
import Alamofire


protocol Parameter {
    static var key: String { get }
    var value: Any { get }
}

protocol NestableParameter {
    typealias Pair = (nestedKey: String?, value: Any)
    static var key: String { get }
    var pair: Pair { get }
}

private func encodedDictionary<T: Parameter>(_ parameters: [T]) -> [String: Any] {
    return [T.key: parameters.map({ "\($0.value)" }).joined(separator: ",")]
}

private func encodedDictionary<T: NestableParameter>(_ parameters: [T]) -> [String: Any] {
    var dict = [String: Any]()
    for parameter in parameters {
        switch parameter.pair {
        case (let nestedKey?, let value):
            dict["\(T.key)[\(nestedKey)]"] = value
        case (_, let value):
            dict[T.key] = value
        }
    }
    return dict
}

extension Dictionary where Key == String, Value == Any {
    mutating func merge<T: Parameter>(with parameters: [T]) {
        return merge(encodedDictionary(parameters), uniquingKeysWith: { $1 })
    }
    
    mutating func merge<T: NestableParameter>(with parameters: [T]) {
        return merge(encodedDictionary(parameters), uniquingKeysWith: { $1 })
    }
}
