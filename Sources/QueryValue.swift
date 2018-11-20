//
//  QueryValue.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 20/11/2018.
//

import Foundation

public protocol QueryValueRepresentable {
    associatedtype QueryValueType
    var rawValue: QueryValueType { get }
}

extension String: QueryValueRepresentable {
    public typealias QueryValueType = String
    public var rawValue: String { return self }
}

extension Int: QueryValueRepresentable {
    public typealias QueryValueType = Int
    public var rawValue: Int { return self }
}

