//
//  AdditionalHTTPHeadersTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Stefan Paychère on 01.01.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class AdditionalHTTPHeadersTests: XCTestCase {

    private let configuration = APIConfiguration(issuerID: UUID().uuidString,
                                                 privateKeyID: UUID().uuidString,
                                                 privateKey: "MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgPaXyFvZfNydDEjxgjUCUxyGjXcQxiulEdGxoVbasV3GgCgYIKoZIzj0DAQehRANCAASflx/DU3TUWAoLmqE6hZL9A7i0DWpXtmIDCDiITRznC6K4/WjdIcuMcixy+m6O0IrffxJOablIX2VM8sHRscdr")

    func testDefaultInit() {
        let apiProvider = APIProvider(configuration: configuration)

        apiProvider.defaultSessionManager.startRequestsImmediately = false // disable actual sending
        let request = apiProvider.defaultSessionManager.request(URL(string: "127.0.0.1")!)
        let headers = request.task?.currentRequest?.allHTTPHeaderFields

        XCTAssertTrue(headers?.count ?? 0 >= 1)
        XCTAssertNotNil(headers?["Authorization"])
    }
    
    func testInitWithHeaders() {
        let myKey = "X-Private-Header"
        let myValue = "Some-Value"
        let myHeaders = [myKey: myValue]
        let apiProvider = APIProvider(configuration: configuration, httpAdditionalHeaders: myHeaders)
        
        apiProvider.defaultSessionManager.startRequestsImmediately = false // disable actual sending
        let request = apiProvider.defaultSessionManager.request(URL(string: "127.0.0.1")!)
        let headers = request.task?.currentRequest?.allHTTPHeaderFields

        XCTAssertTrue(headers?.count ?? 0 >= 2)
        XCTAssertEqual(headers?[myKey], myValue)
    }

}
