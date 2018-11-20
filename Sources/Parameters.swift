//
//  Parameters.swift
//  Alamofire
//
//  Created by Pascal Edmond on 20/11/2018.
//

import Foundation


protocol Parameter {
    static var key: String { get }
    var value: Any { get }
}

func encoded<T: Parameter>(_ parameters: [T]) -> [String: Any] {
    
    return [T.key: parameters.map({ "\($0.value)" }).joined(separator: ",")]
}

protocol NestableParameter {
    typealias Pair = (nestedKey: String?, value: Any)
    static var key: String { get }
    var pair: Pair { get }
}

func encoded<T: NestableParameter>(_ parameters: [T]) -> [String: Any] {
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
    public mutating func mergeOrReplace(_ other: [String: Any]) {
        return self.merge(other, uniquingKeysWith: { (old, new) -> Any in return new })
    }
}
