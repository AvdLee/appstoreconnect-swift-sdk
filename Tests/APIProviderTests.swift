//
//  APIProviderTests.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Michael Schwarz on 07.03.19.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class APIProviderTests: XCTestCase {

    private struct MockRequestExecutor<T>: RequestExecutor {

        let expectedResponse: Result<Response<T>, Swift.Error>

        init(expectedResponse: Result<Response<T>, Swift.Error>) {
            self.expectedResponse = expectedResponse
        }

        func execute(_ urlRequest: URLRequest, completion: @escaping (Result<Response<Data>, Swift.Error>) -> Void) {
            if let response = expectedResponse as? Result<Response<Data>, Swift.Error> {
                completion(response)
            }
        }

        func retrieve(_ url: URL, completion: @escaping (Result<Response<Data>, Swift.Error>) -> Void) {
            if let response = expectedResponse as? Result<Response<Data>, Swift.Error> {
                completion(response)
            }
        }

        func download(_ urlRequest: URLRequest, completion: @escaping (Result<Response<URL>, Error>) -> Void) {
            if let response = expectedResponse as? Result<Response<URL>, Swift.Error> {
                completion(response)
            }
        }

    }

    private let configuration = APIConfiguration(issuerID: UUID().uuidString, privateKeyID: UUID().uuidString, privateKey: "MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgPaXyFvZfNydDEjxgjUCUxyGjXcQxiulEdGxoVbasV3GgCgYIKoZIzj0DAQehRANCAASflx/DU3TUWAoLmqE6hZL9A7i0DWpXtmIDCDiITRznC6K4/WjdIcuMcixy+m6O0IrffxJOablIX2VM8sHRscdr")

    // MARK: - Tests

    func testRequestExecutionWithVoidResponse() {
        let response = Response<Data>(statusCode: 200, data: nil)
        let mockRequestExecutor = MockRequestExecutor(expectedResponse: Result.success(response))
        let apiProvider = APIProvider(configuration: configuration, requestExecutor: mockRequestExecutor)

        let sampleEndpoint = APIEndpoint.delete(betaGroupWithId: "mockID")
        apiProvider.request(sampleEndpoint) { result in
            // using the mock request executor the block is called sync
            XCTAssertTrue(result.isSuccess)
        }
    }

    func testRequestExecutionErrorResponse() {
        let response = Response<Data>(statusCode: 500, data: nil)
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
                                                    included: nil,
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
                                                    included: nil,
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
                    case let APIProvider.Error.decodingError(_, data) = error else {
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
        let response = Response<Data>(statusCode: 500, data: nil)
        let mockRequestExecutor = MockRequestExecutor(expectedResponse: Result.success(response))
        let apiProvider = APIProvider(configuration: configuration, requestExecutor: mockRequestExecutor)
        let resourceLink = ResourceLinks<BetaTester>(self: URL(string: "https://api.appstoreconnect.com?cursor=FIRST")!)
        apiProvider.request(resourceLink) { result in
            // using the mock request executor the block is called sync
            XCTAssertTrue(result.isFailure)
        }
    }

    func testRequestWithDataResultSuccess() {
        let response = Response(statusCode: 200, data: Data(base64Encoded: ""))
        let mockRequestExecutor = MockRequestExecutor(expectedResponse: Result.success(response))

        let apiProvider = APIProvider(configuration: configuration, requestExecutor: mockRequestExecutor)
        let resourceLink = ResourceLinks<Data>(self: URL(string: "https://api.appstoreconnect.com?cursor=FIRST")!)
        apiProvider.request(resourceLink) { result in
            // using the mock request executor the block is called sync
            XCTAssertTrue(result.isSuccess)
            XCTAssertEqual(result.value!, Data(base64Encoded: ""))
            XCTAssertNotEqual(result.value!, Data(base64Encoded: "foo"))
        }
    }

    func testDownloadRequestWithResultSuccess() {
        let response = Response(statusCode: 200, data: URL(fileURLWithPath: "randompath"))
        let mockRequestExecutor = MockRequestExecutor(expectedResponse: Result.success(response))

        let apiProvider = APIProvider(configuration: configuration, requestExecutor: mockRequestExecutor)
        let reportEndpoint = APIEndpoint.downloadSalesAndTrendsReports()
        apiProvider.download(reportEndpoint) { result in
            // using the mock request executor the block is called sync
            XCTAssertTrue(result.isSuccess)
            XCTAssertEqual(result.value!, URL(fileURLWithPath: "randompath"))
        }
    }

    func testDownloadRequestWithProblemOnFileCreation() {
        let response = Response<URL>(statusCode: 200, data: nil)
        let mockRequestExecutor = MockRequestExecutor(expectedResponse: Result.success(response))

        let apiProvider = APIProvider(configuration: configuration, requestExecutor: mockRequestExecutor)
        let reportEndpoint = APIEndpoint.downloadSalesAndTrendsReports()
        apiProvider.download(reportEndpoint) { result in
            // using the mock request executor the block is called sync
            XCTAssertTrue(result.isFailure)
            guard
                let error = result.error as? APIProvider.Error else {
                    XCTFail("We expect a requestFailure error")
                    return
            }
            XCTAssert(error.debugDescription == APIProvider.Error.downloadError.debugDescription)

        }
    }

    func testDownloadRequestWithFailure() {
        let response = Response<URL>(statusCode: 500, data: nil)
        let mockRequestExecutor = MockRequestExecutor(expectedResponse: Result.success(response))

        let apiProvider = APIProvider(configuration: configuration, requestExecutor: mockRequestExecutor)
        let reportEndpoint = APIEndpoint.downloadSalesAndTrendsReports()
        apiProvider.download(reportEndpoint) { result in
            // using the mock request executor the block is called sync
            XCTAssertTrue(result.isFailure)

        }
    }

    func testDateDecoding() throws {
        let decoder = APIProvider.jsonDecoder
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        outputFormatter.locale = Locale(identifier: "en_US_POSIX")
        outputFormatter.timeZone = TimeZone(identifier: "GMT")
        let dateFrom: (String) throws -> String = { dateString in
            let date = try decoder.decode(Date.self, from: "\"\(dateString)\"".data(using: .utf8)!)
            return outputFormatter.string(from: date)
        }

        // yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX
        XCTAssertEqual(try dateFrom("2001-01-01T1:53:20.000Z"), "Mon, 1 Jan 2001 01:53:20 +0000")

        // yyyy-MM-dd'T'HH:mm:ssXXXXX
        XCTAssertEqual(try dateFrom("2001-01-01T1:53:20Z"), "Mon, 1 Jan 2001 01:53:20 +0000")

        // yyyy-MM-dd'T'HH:mm:ssZZZZZ (Bug #124)
        XCTAssertEqual(try dateFrom("2001-01-01T1:53:20+01:00"), "Mon, 1 Jan 2001 00:53:20 +0000")
        XCTAssertEqual(try dateFrom("2001-01-01T1:53:20-01:00"), "Mon, 1 Jan 2001 02:53:20 +0000")
    }

}
