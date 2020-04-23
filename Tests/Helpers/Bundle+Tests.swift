//
//  Bundle+Tests.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Oliver Jones on 17/4/20.
//

import Foundation

extension Bundle {
    static let tests = Bundle(for: BundleTag.self)
}

private final class BundleTag {}
