//
//  APIProviderTests.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Michael Schwarz on 07.03.19.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class APIProviderTests: XCTestCase {

    private struct MockRequestExecutor<T:Codable>: RequestExecutor {

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

    private var configuration: APIConfiguration!

    override func setUp() async throws {
        // swiftlint:disable:next line_length
        let privateKey = "MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgPaXyFvZfNydDEjxgjUCUxyGjXcQxiulEdGxoVbasV3GgCgYIKoZIzj0DAQehRANCAASflx/DU3TUWAoLmqE6hZL9A7i0DWpXtmIDCDiITRznC6K4/WjdIcuMcixy+m6O0IrffxJOablIX2VM8sHRscdr"
        configuration = try APIConfiguration(issuerID: UUID().uuidString,
                                             privateKeyID: UUID().uuidString,
                                             privateKey: privateKey)
    }

    // MARK: - Tests

    func testRequestExecutionWithVoidResponse() {
        let response = Response<Data>(requestURL: nil, statusCode: 200, rateLimit: nil, data: nil)
        let mockRequestExecutor = MockRequestExecutor(expectedResponse: Result.success(response))
        let apiProvider = APIProvider(configuration: configuration, requestExecutor: mockRequestExecutor)

        let sampleEndpoint = APIEndpoint.v1.betaGroups.id("mockID").delete
        apiProvider.request(sampleEndpoint) { result in
            // using the mock request executor the block is called sync
            XCTAssertTrue(result.isSuccess)
        }
    }

    func testRequestExecutionErrorResponse() throws {
        let expectedURL = URL(string: "https://api.appstoreconnect.apple.com")!
        let errorResponse = ErrorResponse(errors: [
            .init(
                id: UUID().uuidString,
                status: "404",
                code: "NOT_FOUND",
                title: "The specified resource does not exist",
                detail: "There is no resource of type 'builds' with id 'app.appId'"
            )
        ])
        let responseData = try JSONEncoder().encode(errorResponse)
        let response = Response<Data>(requestURL: expectedURL, statusCode: 404, rateLimit: nil, data: responseData)
        let mockRequestExecutor = MockRequestExecutor(expectedResponse: Result.success(response))
        let apiProvider = APIProvider(configuration: configuration, requestExecutor: mockRequestExecutor)

        let sampleEndpoint = APIEndpoint.v1.betaGroups.id("mockID").delete
        apiProvider.request(sampleEndpoint) { result in
            // using the mock request executor the block is called sync
            XCTAssertNotNil(result.error)
            guard
                let error = result.error as? APIProvider.Error,
                case let APIProvider.Error.requestFailure(statusCode, errorResponse, url) = error else {
                XCTFail("We expect a requestFailure error")
                return
            }
            XCTAssertNotNil(errorResponse)
            XCTAssertEqual(statusCode, 404)
            XCTAssertEqual(url?.absoluteString, expectedURL.absoluteString)
            XCTAssertEqual(error.localizedDescription, """
            Request https://api.appstoreconnect.apple.com failed with status code 404. Related response error(s):

            The request failed with response code 404 NOT_FOUND

            The specified resource does not exist. There is no resource of type 'builds' with id 'app.appId').
            """)
        }
    }

    func testDownloadRequestWithResultSuccess() {
        let response = Response(requestURL: nil, statusCode: 200, rateLimit: nil, data: URL(fileURLWithPath: "randompath"))
        let mockRequestExecutor = MockRequestExecutor(expectedResponse: Result.success(response))

        let apiProvider = APIProvider(configuration: configuration, requestExecutor: mockRequestExecutor)

        let reportEndpoint = APIEndpoint.v1.salesReports.get(parameters: .init(filterVendorNumber: [],
                                                                               filterReportType: [],
                                                                               filterReportSubType: [],
                                                                               filterFrequency: []))
        apiProvider.download(reportEndpoint) { result in
            // using the mock request executor the block is called sync
            XCTAssertTrue(result.isSuccess)
            XCTAssertEqual(result.value!, URL(fileURLWithPath: "randompath"))
        }
    }

    func testDownloadRequestWithProblemOnFileCreation() {
        let response = Response<URL>(requestURL: nil, statusCode: 200, rateLimit: nil, data: nil)
        let mockRequestExecutor = MockRequestExecutor(expectedResponse: Result.success(response))

        let apiProvider = APIProvider(configuration: configuration, requestExecutor: mockRequestExecutor)
        let reportEndpoint = APIEndpoint.v1.salesReports.get(parameters: .init(filterVendorNumber: [],
                                                                               filterReportType: [],
                                                                               filterReportSubType: [],
                                                                               filterFrequency: []))
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
        let response = Response<URL>(requestURL: nil, statusCode: 500, rateLimit: nil, data: nil)
        let mockRequestExecutor = MockRequestExecutor(expectedResponse: Result.success(response))

        let apiProvider = APIProvider(configuration: configuration, requestExecutor: mockRequestExecutor)
        let reportEndpoint = APIEndpoint.v1.salesReports.get(parameters: .init(filterVendorNumber: [],
                                                                               filterReportType: [],
                                                                               filterReportSubType: [],
                                                                               filterFrequency: []))
        apiProvider.download(reportEndpoint) { result in
            // using the mock request executor the block is called sync
            XCTAssertTrue(result.isFailure)

        }
    }
}
