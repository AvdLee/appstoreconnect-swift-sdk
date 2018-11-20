//
//  Sorting.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 17/11/2018.
//

import Foundation

public enum Sorting<Field: RawRepresentable>: Parameter {
    case `default`(Field)
    case ascending(Field)
    case descending(Field)
    
    static var key: String { return "sort" }
    public var value: Any {
        switch self {
        case .default(let field):
            return "\(field.rawValue)"
        case .ascending(let field):
            return "+\(field.rawValue)"
        case .descending(let field):
            return "-\(field.rawValue)"
        }
    }
}
