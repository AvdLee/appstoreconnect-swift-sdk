@testable import AppStoreConnect_Swift_SDK
import Foundation
import XCTest

final class ModifyAppStoreVersionTests: XCTestCase {
    func testURLRequest() {
        let id = UUID().uuidString
        let earliestReleaseDate = Date()
        let endpoint = APIEndpoint.modify(appStoreVersionWithId: id,
                                          buildId: "1",
                                          copyright: "mocked_copyright",
                                          earliestReleaseDate: earliestReleaseDate,
                                          releaseType: .manual,
                                          usesIdfa: true,
                                          versionString: "mocked_version",
                                          downloadable: true)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "PATCH")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/appStoreVersions/\(id)"
        XCTAssertEqual(absoluteString, expected)

        let expectedBody = try? JSONEncoder().encode(AppStoreVersionUpdateRequest(id: id,
                                                                                  buildId: "1",
                                                                                  copyright: "mocked_copyright",
                                                                                  earliestReleaseDate: earliestReleaseDate,
                                                                                  releaseType: .manual,
                                                                                  usesIdfa: true,
                                                                                  versionString: "mocked_version",
                                                                                  downloadable: true))
        XCTAssertNotNil(request?.httpBody)
        XCTAssertEqual(request?.httpBody, expectedBody )
    }
}
