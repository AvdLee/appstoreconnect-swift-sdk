import Foundation
import XCTest
import AppStoreConnectCore
@testable import ReleaseSubmission

final class ReleaseSubmitterTests: XCTestCase {
    private let plan = ReleasePlan(appID: "app-1", versionString: "2.0", buildNumber: "42", whatsNew: "Faster sync.")

    func testSubmitsAnExistingVersionWithEveryLocalizationAndTheIncludedGameCenterVersion() async throws {
        let executor = RecordingExecutor(responses: Self.responses(versions: Self.existingVersions))
        let release = try await ReleaseSubmitter(provider: try self.provider(executor)).submit(self.plan)

        XCTAssertEqual(release, SubmittedRelease(
            versionID: "version-1",
            buildID: "build-42",
            reviewSubmissionID: "submission-1",
            updatedLocalizationIDs: ["loc-en", "loc-de"],
            gameCenterAppVersionID: "gc-1"
        ))
        XCTAssertEqual(executor.requests.map(\.route), [
            "GET /v1/builds",
            "GET /v1/apps/app-1/appStoreVersions",
            "PATCH /v1/appStoreVersions/version-1",
            "PATCH /v1/appStoreVersionLocalizations/loc-en",
            "PATCH /v1/appStoreVersionLocalizations/loc-de",
            "POST /v1/reviewSubmissions",
            "POST /v1/reviewSubmissionItems",
            "PATCH /v1/reviewSubmissions/submission-1",
        ])

        let buildQuery = try XCTUnwrap(executor.requests.first?.query)
        XCTAssertTrue(buildQuery.contains("filter[version]=42"), buildQuery)
        XCTAssertTrue(buildQuery.contains("filter[app]=app-1"), buildQuery)
        let versionQuery = try XCTUnwrap(executor.requests[1].query)
        XCTAssertTrue(versionQuery.contains("include=appStoreVersionLocalizations,gameCenterAppVersion"), versionQuery)

        let attachBuild = try executor.json(at: 2)
        XCTAssertEqual(attachBuild.value(at: "data.relationships.build.data.id") as? String, "build-42")
        XCTAssertEqual(try executor.json(at: 3).value(at: "data.attributes.whatsNew") as? String, "Faster sync.")
        let item = try executor.json(at: 6)
        XCTAssertEqual(item.value(at: "data.relationships.reviewSubmission.data.id") as? String, "submission-1")
        XCTAssertEqual(item.value(at: "data.relationships.appStoreVersion.data.id") as? String, "version-1")
        XCTAssertEqual(try executor.json(at: 7).value(at: "data.attributes.submitted") as? Bool, true)
    }

    func testCreatesTheVersionWhenItDoesNotExistYet() async throws {
        let executor = RecordingExecutor(responses: Self.responses(versions: Self.noVersions))
        let release = try await ReleaseSubmitter(provider: try self.provider(executor)).submit(self.plan)

        XCTAssertEqual(release.versionID, "version-new")
        XCTAssertEqual(release.updatedLocalizationIDs, [])
        XCTAssertNil(release.gameCenterAppVersionID)
        XCTAssertEqual(executor.requests[2].route, "POST /v1/appStoreVersions")
        let create = try executor.json(at: 2)
        XCTAssertEqual(create.value(at: "data.attributes.versionString") as? String, "2.0")
        XCTAssertEqual(create.value(at: "data.attributes.platform") as? String, "IOS")
        XCTAssertEqual(create.value(at: "data.relationships.app.data.id") as? String, "app-1")
        XCTAssertEqual(executor.requests[3].route, "PATCH /v1/appStoreVersions/version-new")
    }

    func testMissingBuildStopsBeforeChangingAnything() async throws {
        var responses = Self.responses(versions: Self.existingVersions)
        responses["GET /v1/builds"] = #"{"data": [], "links": {"self": "https://api.appstoreconnect.apple.com/v1/builds"}}"#
        let executor = RecordingExecutor(responses: responses)

        do {
            _ = try await ReleaseSubmitter(provider: try self.provider(executor)).submit(self.plan)
            XCTFail("Expected buildNotFound")
        } catch let error as ReleaseError {
            XCTAssertEqual(error, .buildNotFound("42"))
        }
        XCTAssertEqual(executor.requests.map(\.route), ["GET /v1/builds"])
    }

    // MARK: - Recorded responses

    private func provider(_ executor: RecordingExecutor) throws -> APIProvider {
        // A throwaway P-256 key; requests never leave the process.
        let privateKey = "MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgPaXyFvZfNydDEjxgjUCUxyGjXcQxiulEdGxoVbasV3GgCgYIKoZIzj0DAQehRANCAASflx/DU3TUWAoLmqE6hZL9A7i0DWpXtmIDCDiITRznC6K4/WjdIcuMcixy+m6O0IrffxJOablIX2VM8sHRscdr"
        let configuration = try APIConfiguration(issuerID: "issuer", privateKeyID: "key", privateKey: privateKey)
        return APIProvider(configuration: configuration, requestExecutor: executor)
    }

    private static let links = #""links": {"self": "https://api.appstoreconnect.apple.com"}"#

    private static let existingVersions = #"""
    {
      "data": [{"type": "appStoreVersions", "id": "version-1", "attributes": {"versionString": "2.0", "platform": "IOS"}}],
      "included": [
        {"type": "appStoreVersionLocalizations", "id": "loc-en", "attributes": {"locale": "en-US"}},
        {"type": "gameCenterAppVersions", "id": "gc-1", "attributes": {"enabled": true}},
        {"type": "appStoreVersionLocalizations", "id": "loc-de", "attributes": {"locale": "de-DE"}}
      ],
      "links": {"self": "https://api.appstoreconnect.apple.com"}
    }
    """#

    private static let noVersions = #"{"data": [], "links": {"self": "https://api.appstoreconnect.apple.com"}}"#

    private static func responses(versions: String) -> [String: String] {
        [
            "GET /v1/builds": #"{"data": [{"type": "builds", "id": "build-42", "attributes": {"version": "42"}}], \#(links)}"#,
            "GET /v1/apps/app-1/appStoreVersions": versions,
            "POST /v1/appStoreVersions": #"{"data": {"type": "appStoreVersions", "id": "version-new"}, \#(links)}"#,
            "PATCH /v1/appStoreVersions/version-1": #"{"data": {"type": "appStoreVersions", "id": "version-1"}, \#(links)}"#,
            "PATCH /v1/appStoreVersions/version-new": #"{"data": {"type": "appStoreVersions", "id": "version-new"}, \#(links)}"#,
            "PATCH /v1/appStoreVersionLocalizations/loc-en": #"{"data": {"type": "appStoreVersionLocalizations", "id": "loc-en"}, \#(links)}"#,
            "PATCH /v1/appStoreVersionLocalizations/loc-de": #"{"data": {"type": "appStoreVersionLocalizations", "id": "loc-de"}, \#(links)}"#,
            "POST /v1/reviewSubmissions": #"{"data": {"type": "reviewSubmissions", "id": "submission-1"}, \#(links)}"#,
            "POST /v1/reviewSubmissionItems": #"{"data": {"type": "reviewSubmissionItems", "id": "item-1"}, \#(links)}"#,
            "PATCH /v1/reviewSubmissions/submission-1": #"{"data": {"type": "reviewSubmissions", "id": "submission-1"}, \#(links)}"#,
        ]
    }
}

/// Serves recorded responses by method and path, and records every request it receives.
private final class RecordingExecutor: RequestExecutor, @unchecked Sendable {
    struct Recorded {
        var route: String
        var query: String?
        var body: Data?
    }

    private let responses: [String: String]
    private let lock = NSLock()
    private var recorded: [Recorded] = []

    init(responses: [String: String]) {
        self.responses = responses
    }

    var requests: [Recorded] {
        self.lock.lock()
        defer { self.lock.unlock() }
        return self.recorded
    }

    func json(at index: Int) throws -> [String: Any] {
        let body = try XCTUnwrap(self.requests[index].body, "Request \(index) has no body")
        return try XCTUnwrap(JSONSerialization.jsonObject(with: body) as? [String: Any])
    }

    func execute(_ urlRequest: URLRequest, completion: @escaping @Sendable (Result<Response<Data>, Error>) -> Void) {
        let route = "\(urlRequest.httpMethod ?? "GET") \(urlRequest.url?.path ?? "")"
        self.lock.lock()
        self.recorded.append(Recorded(route: route, query: urlRequest.url?.query?.removingPercentEncoding, body: urlRequest.httpBody))
        self.lock.unlock()

        guard let body = self.responses[route] else {
            completion(.success(Response(requestURL: urlRequest.url, statusCode: 404, rateLimit: nil, data: Data())))
            return
        }
        completion(.success(Response(requestURL: urlRequest.url, statusCode: 200, rateLimit: nil, data: Data(body.utf8))))
    }

    func download(_ urlRequest: URLRequest, completion: @escaping @Sendable (Result<Response<URL>, Error>) -> Void) {
        completion(.failure(URLError(.unsupportedURL)))
    }
}

private extension Dictionary where Key == String, Value == Any {
    func value(at keyPath: String) -> Any? {
        var current: Any? = self
        for key in keyPath.split(separator: ".") {
            current = (current as? [String: Any])?[String(key)]
        }
        return current
    }
}
