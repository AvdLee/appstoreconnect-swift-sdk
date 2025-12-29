//
//  APIProviderTests.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Michael Schwarz on 07.03.19.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

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
        let mockRequestExecutor = MockRequestExecutor<Data>(expectedResponse: .success(response))
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
            ResponseError(
                id: UUID().uuidString,
                status: "404",
                code: "NOT_FOUND",
                title: "The specified resource does not exist",
                detail: "There is no resource of type 'builds' with id 'app.appId'"
            )
        ])
        let responseData = try JSONEncoder().encode(errorResponse)
        let response = Response<Data>(requestURL: expectedURL, statusCode: 404, rateLimit: nil, data: responseData)
        let mockRequestExecutor = MockRequestExecutor<Data>(expectedResponse: .success(response))
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
        let mockRequestExecutor = MockRequestExecutor<URL>(expectedResponse: .success(response))

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
        let mockRequestExecutor = MockRequestExecutor<URL>(expectedResponse: .success(response))

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
        let mockRequestExecutor = MockRequestExecutor<URL>(expectedResponse: .success(response))

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

    // MARK: - Date Decoding Tests

    private struct DateWrapper: Codable {
        let date: Date
    }

    /// Test date format: yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX (with milliseconds and timezone offset)
    func testDateDecodingWithMillisecondsAndTimezoneOffset() throws {
        let json = #"{"date": "2024-01-01T23:59:59.123+00:00"}"#
        let data = json.data(using: .utf8)!
        let decoded = try APIProvider.jsonDecoder.decode(DateWrapper.self, from: data)
        XCTAssertNotNil(decoded.date)

        // Verify the date components
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: decoded.date)
        XCTAssertEqual(components.year, 2024)
        XCTAssertEqual(components.month, 1)
        XCTAssertEqual(components.day, 1)
        XCTAssertEqual(components.hour, 23)
        XCTAssertEqual(components.minute, 59)
        XCTAssertEqual(components.second, 59)
    }

    /// Test date format: yyyy-MM-dd'T'HH:mm:ssXXXXX (without milliseconds, with timezone offset)
    func testDateDecodingWithoutMillisecondsAndTimezoneOffset() throws {
        let json = #"{"date": "2025-10-01T19:37:15-07:00"}"#
        let data = json.data(using: .utf8)!
        let decoded = try APIProvider.jsonDecoder.decode(DateWrapper.self, from: data)
        XCTAssertNotNil(decoded.date)

        // Verify the date components (converted to UTC: 19:37:15 - (-07:00) = 02:37:15 next day)
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: decoded.date)
        XCTAssertEqual(components.year, 2025)
        XCTAssertEqual(components.month, 10)
        XCTAssertEqual(components.day, 2)
        XCTAssertEqual(components.hour, 2)
        XCTAssertEqual(components.minute, 37)
        XCTAssertEqual(components.second, 15)
    }

    /// Test date format with Z timezone (UTC)
    func testDateDecodingWithZTimezone() throws {
        let json = #"{"date": "2025-12-28T23:57:15Z"}"#
        let data = json.data(using: .utf8)!
        let decoded = try APIProvider.jsonDecoder.decode(DateWrapper.self, from: data)
        XCTAssertNotNil(decoded.date)

        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: decoded.date)
        XCTAssertEqual(components.year, 2025)
        XCTAssertEqual(components.month, 12)
        XCTAssertEqual(components.day, 28)
        XCTAssertEqual(components.hour, 23)
        XCTAssertEqual(components.minute, 57)
        XCTAssertEqual(components.second, 15)
    }

    /// Test date format from customer reviews API: 2025-11-06T06:40:31-08:00
    func testDateDecodingFromCustomerReviewsAPI() throws {
        let json = #"{"date": "2025-11-06T06:40:31-08:00"}"#
        let data = json.data(using: .utf8)!
        let decoded = try APIProvider.jsonDecoder.decode(DateWrapper.self, from: data)
        XCTAssertNotNil(decoded.date)

        // Verify the date components (converted to UTC: 06:40:31 + 08:00 = 14:40:31)
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: decoded.date)
        XCTAssertEqual(components.year, 2025)
        XCTAssertEqual(components.month, 11)
        XCTAssertEqual(components.day, 6)
        XCTAssertEqual(components.hour, 14)
        XCTAssertEqual(components.minute, 40)
        XCTAssertEqual(components.second, 31)
    }

    /// Test date format with milliseconds and Z timezone
    func testDateDecodingWithMillisecondsAndZTimezone() throws {
        let json = #"{"date": "2024-01-01T12:30:45.678Z"}"#
        let data = json.data(using: .utf8)!
        let decoded = try APIProvider.jsonDecoder.decode(DateWrapper.self, from: data)
        XCTAssertNotNil(decoded.date)

        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: decoded.date)
        XCTAssertEqual(components.year, 2024)
        XCTAssertEqual(components.month, 1)
        XCTAssertEqual(components.day, 1)
        XCTAssertEqual(components.hour, 12)
        XCTAssertEqual(components.minute, 30)
        XCTAssertEqual(components.second, 45)
    }

    /// Test that invalid date format throws an error
    func testDateDecodingWithInvalidFormat() {
        let json = #"{"date": "invalid-date-format"}"#
        let data = json.data(using: .utf8)!

        XCTAssertThrowsError(try APIProvider.jsonDecoder.decode(DateWrapper.self, from: data)) { error in
            // Verify it's a decoding error
            guard case APIProvider.Error.dateDecodingError("invalid-date-format") = error else {
                XCTFail()
                return
            }
        }
    }

    /// Test date format with positive timezone offset
    func testDateDecodingWithPositiveTimezoneOffset() throws {
        let json = #"{"date": "2025-06-15T10:30:00+05:30"}"#
        let data = json.data(using: .utf8)!
        let decoded = try APIProvider.jsonDecoder.decode(DateWrapper.self, from: data)
        XCTAssertNotNil(decoded.date)

        // Verify the date components (converted to UTC: 10:30:00 - 05:30 = 05:00:00)
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: decoded.date)
        XCTAssertEqual(components.year, 2025)
        XCTAssertEqual(components.month, 6)
        XCTAssertEqual(components.day, 15)
        XCTAssertEqual(components.hour, 5)
        XCTAssertEqual(components.minute, 0)
        XCTAssertEqual(components.second, 0)
    }
}
