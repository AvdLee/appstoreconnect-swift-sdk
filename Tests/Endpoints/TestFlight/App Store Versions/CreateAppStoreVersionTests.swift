@testable import AppStoreConnect_Swift_SDK
import Foundation
import XCTest

final class CreateAppStoreVersionTests: XCTestCase {
    func testURLRequest() {
        let id = UUID().uuidString
        let buildId = UUID().uuidString
        let earliestReleaseDate = Date()
        let endpoint = APIEndpoint.create(appStoreVersionForAppId: id,
                                          versionString: "mocked_version",
                                          platform: .iOS,
                                          copyright: "mocked_copyright",
                                          earliestReleaseDate: earliestReleaseDate,
                                          releaseType: .manual,
                                          usesIdfa: true,
                                          buildId: buildId)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "POST")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/appStoreVersions"
        XCTAssertEqual(absoluteString, expected)

        let expectedBody = try? JSONEncoder().encode(AppStoreVersionCreateRequest(appStoreVersionForAppId: id,
                                                                                  versionString: "mocked_version",
                                                                                  platform: .iOS,
                                                                                  copyright: "mocked_copyright",
                                                                                  earliestReleaseDate: earliestReleaseDate,
                                                                                  releaseType: .manual,
                                                                                  usesIdfa: true,
                                                                                  buildId: buildId))
        XCTAssertNotNil(request?.httpBody)
        XCTAssertEqual(request?.httpBody, expectedBody )
    }
}
