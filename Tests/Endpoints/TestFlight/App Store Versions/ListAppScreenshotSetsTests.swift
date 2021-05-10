@testable import AppStoreConnect_Swift_SDK
import XCTest

final class ListAppScreenshotSetsTests: XCTestCase {
    func testURLRequest() {
        let id = UUID().uuidString
        let endpoint = APIEndpoint.appScreenshotSets(
            forAppStoreVersionLocalization: id,
            fields: [
                .appScreenshotSets([
                    .appScreenshots,
                    .appStoreVersionLocalization,
                    .screenshotDisplayType
                ]),
                .appScreenshots([
                    .appScreenshotSet,
                    .assetDeliveryState,
                    .assetToken,
                    .assetType,
                    .fileName,
                    .fileSize,
                    .imageAsset,
                    .sourceFileChecksum,
                    .uploadOperations,
                    .uploaded
                ]),
                .appStoreVersionLocalizations([.locale])
            ], includes: [
                .appScreenshots,
                .appStoreVersionLocalization
            ], limit: 50
        )

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected =
            "https://api.appstoreconnect.apple.com/v1/appStoreVersions/\(id)/appScreenshotSets?fields%5BappScreenshotSets%5D=appScreenshots%2CappStoreVersionLocalization%2CscreenshotDisplayType&fields%5BappScreenshots%5D=appScreenshotSet%2CassetDeliveryState%2CassetToken%2CassetType%2CfileName%2CfileSize%2CimageAsset%2CsourceFileChecksum%2CuploadOperations%2Cuploaded&fields%5BappStoreVersionLocalizations%5D=locale&include=appScreenshots%2CappStoreVersionLocalization&limit=50"
        XCTAssertEqual(absoluteString, expected)
    }
}
