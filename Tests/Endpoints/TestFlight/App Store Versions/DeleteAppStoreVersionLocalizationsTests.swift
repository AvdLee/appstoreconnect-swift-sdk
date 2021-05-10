@testable import AppStoreConnect_Swift_SDK
import XCTest

final class DeleteAppStoreVersionLocalizationsTests: XCTestCase {
    func testURLRequest() {
        let id = UUID().uuidString
        let endpoint = APIEndpoint.delete(appStoreVersionLocalizationWithId: id)

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "DELETE")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/appStoreVersionLocalizations/\(id)"
        XCTAssertEqual(absoluteString, expected)
    }
}
