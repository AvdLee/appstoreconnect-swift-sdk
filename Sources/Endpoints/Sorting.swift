//
//  Sorting.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 17/11/2018.
//

import Foundation

public enum Sorting<T: SortableValue> {
    case `default`(T)
    case ascending(T)
    case descending(T)
}

public protocol SortableValue {
    var rawValue: String { get }
}

extension String: SortableValue {
    public var rawValue: String {
        return self
    }
}
