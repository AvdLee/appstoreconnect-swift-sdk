//
//  NestableQueryParameterTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 23/11/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class NestableQueryParameterTests: XCTestCase {
    
    func testNestableQueryParameter() {
        
        struct MockParameterCluster: NestableQueryParameter {
            static var key: String = "key"
            var pair: NestableQueryParameter.Pair
        }
        
        var dict = [String: Any]()
        
        // Adding a parameter
        let value = "value"
        let rootParam1 = MockParameterCluster(pair: (nestedKey: nil, value: value))
        dict.add([rootParam1])
        XCTAssertTrue(dict.count == 1)
        XCTAssertEqual(dict[MockParameterCluster.key] as? String, value)
        
        // Adding a parameter with same key overrides previous value
        let newValue = "newValue"
        let rootParam2 = MockParameterCluster(pair: (nestedKey: nil, value: newValue))
        dict.add([rootParam2])
        XCTAssertTrue(dict.count == 1)
        XCTAssertEqual(dict[MockParameterCluster.key] as? String, newValue)
        
        // Adding a parameter
        let nestedKey = "nested"
        let nestedParam1 = MockParameterCluster(pair: (nestedKey: nestedKey, value: value))
        dict.add([nestedParam1])
        XCTAssertTrue(dict.count == 2)
        XCTAssertEqual(dict["\(MockParameterCluster.key)[\(nestedKey)]"] as? String, value)
        
        // Adding a parameter with same key overrides previous value
        let nestedParam2 = MockParameterCluster(pair: (nestedKey: nestedKey, value: newValue))
        dict.add([nestedParam2])
        XCTAssertTrue(dict.count == 2)
        XCTAssertEqual(dict["\(MockParameterCluster.key)[\(nestedKey)]"] as? String, newValue)
    }
}
