@testable import AppStoreConnect_Swift_SDK
import XCTest

final class ListAppPreviewSetsTests: XCTestCase {
    func testURLRequest() {
        let id = UUID().uuidString
        let endpoint = APIEndpoint.appPreviewSets(
            forAppStoreVersionLocalization: id,
            fields: [
                .appPreviewSets([
                    .appPreviews,
                    .appStoreVersionLocalization,
                    .previewType
                ]),
                .appPreviews([
                    .appPreviewSet,
                    .assetDeliveryState,
                    .fileName,
                    .fileSize,
                    .mimeType,
                    .previewFrameTimeCode,
                    .previewImage,
                    .sourceFileChecksum,
                    .uploadOperations,
                    .uploaded
                ])
            ], includes: [
                .appPreviews,
                .appStoreVersionLocalization
            ], limit: 50
        )

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected =
            "https://api.appstoreconnect.apple.com/v1/appStoreVersions/\(id)/appPreviewSets?fields%5BappPreviewSets%5D=appPreviews%2CappStoreVersionLocalization%2CpreviewType&fields%5BappPreviews%5D=appPreviewSet%2CassetDeliveryState%2CfileName%2CfileSize%2CmimeType%2CpreviewFrameTimeCode%2CpreviewImage%2CsourceFileChecksum%2CuploadOperations%2Cuploaded&include=appPreviews%2CappStoreVersionLocalization&limit=50"
        XCTAssertEqual(absoluteString, expected)
    }
}
