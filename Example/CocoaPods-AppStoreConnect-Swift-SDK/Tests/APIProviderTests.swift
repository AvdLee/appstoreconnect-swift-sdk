//
//  APIProviderTests.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Michael Schwarz on 07.03.19.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class APIProviderTests: XCTestCase {

    private struct MockRequestExecutor: RequestExecutor {

        let expectedResponse: Result<Response>

        init(expectedResponse:  Result<Response>) {
            self.expectedResponse = expectedResponse
        }

        func execute(_ urlRequest: URLRequest, completion: @escaping (Result<Response>) -> Void) {
            completion(expectedResponse)
        }

        func retrieve(_ url: URL, completion: @escaping (Result<Response>) -> Void) {
            completion(expectedResponse)
        }
    }

    private let configuration = APIConfiguration(issuerID: UUID().uuidString, privateKeyID: UUID().uuidString, privateKey: "MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgPaXyFvZfNydDEjxgjUCUxyGjXcQxiulEdGxoVbasV3GgCgYIKoZIzj0DAQehRANCAASflx/DU3TUWAoLmqE6hZL9A7i0DWpXtmIDCDiITRznC6K4/WjdIcuMcixy+m6O0IrffxJOablIX2VM8sHRscdr")

    // MARK: - Tests

    func testRequestExecutionWithVoidResponse() {
        let response = Response(statusCode: 200, data: nil)
        let mockRequestExecutor = MockRequestExecutor(expectedResponse: Result.success(response))
        let apiProvider = APIProvider(configuration: configuration, requestExecutor: mockRequestExecutor)

        let sampleEndpoint = APIEndpoint.delete(betaGroupWithId: "mockID")
        apiProvider.request(sampleEndpoint) { result in
            // using the mock request executor the block is called sync
            XCTAssertTrue(result.isSuccess)
        }
    }

    func testRequestExecutionErrorResponse() {
        let response = Response(statusCode: 500, data: nil)
        let mockRequestExecutor = MockRequestExecutor(expectedResponse: Result.success(response))
        let apiProvider = APIProvider(configuration: configuration, requestExecutor: mockRequestExecutor)

        let sampleEndpoint = APIEndpoint.delete(betaGroupWithId: "mockID")
        apiProvider.request(sampleEndpoint) { result in
            // using the mock request executor the block is called sync
            XCTAssertNotNil(result.error)
            guard
                let error = result.error as? APIProvider.Error,
                case let APIProvider.Error.requestFailure(statusCode, data) = error else {
                XCTFail("We expect a requestFailure error")
                return
            }
            XCTAssertNil(data)
            XCTAssertEqual(statusCode, 500)
        }
    }

    func testRequestWithDecodableResult() {
        let documentLinks = DocumentLinks(self: URL(string: "https://api.appstoreconnect.com?cursor=FIRST")!)
        let betaTesterResponse = BetaTesterResponse(data: .test,
                                                    include: nil,
                                                    links: documentLinks)
        let jsonData = try! JSONEncoder().encode(betaTesterResponse)
        let response = Response(statusCode: 200, data: jsonData)
        let mockRequestExecutor = MockRequestExecutor(expectedResponse: Result.success(response))
        let apiProvider = APIProvider(configuration: configuration, requestExecutor: mockRequestExecutor)

        let sampleEndpoint = APIEndpoint.betaTester(withId: "mockID")
        apiProvider.request(sampleEndpoint) { result in
            // using the mock request executor the block is called sync
            XCTAssertTrue(result.isSuccess)
            XCTAssertNotNil(result.value)
        }
    }

    func testRequestWithDecodableResultFailure() {
        let documentLinks = DocumentLinks(self: URL(string: "https://api.appstoreconnect.com?cursor=FIRST")!)
        let betaTesterResponse = BetaTesterResponse(data: .test,
                                                    include: nil,
                                                    links: documentLinks)
        let jsonData = try! JSONEncoder().encode(betaTesterResponse)

        // test response with data and error status code
        do {
            let response = Response(statusCode: 400, data: jsonData)
            let mockRequestExecutor = MockRequestExecutor(expectedResponse: Result.success(response))
            let apiProvider = APIProvider(configuration: configuration, requestExecutor: mockRequestExecutor)

            let sampleEndpoint = APIEndpoint.betaGroups()
            apiProvider.request(sampleEndpoint) { result in
                // using the mock request executor the block is called sync
                XCTAssertTrue(result.isFailure)
                XCTAssertNotNil(result.error)
                guard
                    let error = result.error as? APIProvider.Error,
                    case let APIProvider.Error.requestFailure(statusCode, data) = error else {
                        XCTFail("We expect a requestFailure error")
                        return
                }
                XCTAssertEqual(statusCode, 400)
                XCTAssertNotNil(data)
            }
        }

        // test response with wrong data and success code
        do {
            let response = Response(statusCode: 200, data: jsonData)
            let mockRequestExecutor = MockRequestExecutor(expectedResponse: Result.success(response))
            let apiProvider = APIProvider(configuration: configuration, requestExecutor: mockRequestExecutor)

            let sampleEndpoint = APIEndpoint.betaGroups()
            apiProvider.request(sampleEndpoint) { result in
                // using the mock request executor the block is called sync
                XCTAssertTrue(result.isFailure)
                XCTAssertNotNil(result.error)
                guard
                    let error = result.error as? APIProvider.Error,
                    case let APIProvider.Error.decodingError(data) = error else {
                        XCTFail("We expect a requestFailure error")
                        return
                }
                XCTAssertNotNil(data)
            }
        }
    }

    func testRequestForResourceLink() {
        struct Sample: Codable, Equatable {
            let value: String
        }
        let sample = Sample(value: "Hello World")
        let jsonData = try! JSONEncoder().encode(sample)
        let response = Response(statusCode: 200, data: jsonData)
        let mockRequestExecutor = MockRequestExecutor(expectedResponse: Result.success(response))
        let apiProvider = APIProvider(configuration: configuration, requestExecutor: mockRequestExecutor)
        let resourceLink = ResourceLinks<Sample>(self: URL(string: "https://api.appstoreconnect.com?cursor=FIRST")!)
        apiProvider.request(resourceLink) { result in
            // using the mock request executor the block is called sync
            XCTAssertTrue(result.isSuccess)
            XCTAssertEqual(result.value, sample)
        }
    }

    func testRequestForResourceLinkWithFailure() {
        let response = Response(statusCode: 500, data: nil)
        let mockRequestExecutor = MockRequestExecutor(expectedResponse: Result.success(response))
        let apiProvider = APIProvider(configuration: configuration, requestExecutor: mockRequestExecutor)
        let resourceLink = ResourceLinks<BetaTester>(self: URL(string: "https://api.appstoreconnect.com?cursor=FIRST")!)
        apiProvider.request(resourceLink) { result in
            // using the mock request executor the block is called sync
            XCTAssertTrue(result.isFailure)
        }
    }
}
