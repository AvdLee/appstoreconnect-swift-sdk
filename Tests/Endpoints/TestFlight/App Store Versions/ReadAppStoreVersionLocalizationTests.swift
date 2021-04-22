@testable import AppStoreConnect_Swift_SDK
import XCTest

final class ReadAppStoreVersionLocalizationTests: XCTestCase {
    func testURLRequest() {
        let id = UUID().uuidString
        let endpoint = APIEndpoint.appStoreVersionLocalization(
            withId: id, fields: [
                .appPreviewSets([
                    .appPreviews,
                    .appStoreVersionLocalization,
                    .previewType
                ])
            ], include: [
                .appPreviewSets,
                .appScreenshotSets,
                .appStoreVersion
            ], limits: [
                .appPreviewSets(50),
                .appScreenshotSets(100)
            ]
        )
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected =
            "https://api.appstoreconnect.apple.com/v1/appStoreVersionLocalizations/\(id)?fields%5BappPreviewSets%5D=appPreviews%2CappStoreVersionLocalization%2CpreviewType&include=appPreviewSets%2CappScreenshotSets%2CappStoreVersion&limit%5BappPreviewSets%5D=50&limit%5BappScreenshotSets%5D=100"
        XCTAssertEqual(absoluteString, expected)
    }
}
