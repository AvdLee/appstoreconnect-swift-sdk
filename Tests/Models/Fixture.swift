//
//  Fixture.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Oliver Jones on 17/4/20.
//

import Foundation

struct Fixture {
    var data: Data

    init(named: String, in bundle: Bundle = .tests) throws {

        guard let url = bundle.url(forResource: named, withExtension: "json", subdirectory: "Fixtures.bundle") else {
            fatalError("Unable to find fixture named: \(named)")
        }
        try data = Data(contentsOf: url)
    }
}
