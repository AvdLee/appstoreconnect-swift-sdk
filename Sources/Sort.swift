//
//  Sorting.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 17/11/2018.
//

import Foundation

public enum Sorting<Field: QueryValueRepresentable> {
    case `default`(Field)
    case ascending(Field)
    case descending(Field)
}
