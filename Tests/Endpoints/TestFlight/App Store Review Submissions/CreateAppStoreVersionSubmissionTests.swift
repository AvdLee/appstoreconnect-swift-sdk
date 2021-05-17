@testable import AppStoreConnect_Swift_SDK
import Foundation
import XCTest

final class CreateAppStoreVersionSubmissionTests: XCTestCase {
    func testURLRequest() {
        let id = UUID().uuidString
        let endpoint = APIEndpoint.create(appStoreVersionSubmissionForVersionWithId: id)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "POST")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/appStoreVersionSubmissions"
        XCTAssertEqual(absoluteString, expected)

        let expectedBody = try? JSONEncoder().encode(AppStoreVersionSubmissionCreateRequest(appStoreVersionId: id))
        XCTAssertNotNil(request?.httpBody)
        XCTAssertEqual(request?.httpBody, expectedBody )
    }
}
